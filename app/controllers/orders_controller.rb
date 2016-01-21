class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_order, only: [:add_payment, :save_payment, :review, :confirm]

  def index
    @orders = current_user.orders.includes(line_item: :product)
  end

  def new
    @order = Order.new
    @order.name = current_user.name
    @order.email = current_user.email
  end

  def create
    @order = current_user.orders.build(order_params)
    @order.amount = current_cart.line_item.amount
    @order.line_item = current_cart.line_item

    if @order.save
      session[:cart_id] = nil

      # User.all.each do |u|
      #   if u != current_user
      #     UserMailer.notify_match(u, current_cart.line_item.product).deliver_later!
      #   end
      # end

      redirect_to add_payment_order_path(@order)
    else
      flash[:alert] = '新增失敗'

      render :new
    end
  end

  def add_address
  end

  def save_address
  end

  def add_payment
    user = @order.user
    if user.bt_customer_id.nil?
      result = Braintree::Customer.create
      user.bt_customer_id = result.customer.id
      user.save!
    end

    @bt_client_token = Braintree::ClientToken.generate(customer_id: user.bt_customer_id)
  end

  def save_payment
    nonce = params[:payment_method_nonce]
    result = Braintree::PaymentMethod.create(
      customer_id: @order.user.bt_customer_id,
      payment_method_nonce: nonce
    )

    # response = JSON.parse(params[:response])

    if result.success?
      # @order.braintree_nonce = response['nonce']
      # @order.payment_type = response['type']
      # @order.card_type = response['details']['cardType']
      # @order.card_last_two = response['details']['lastTwo']
      # @order.save

      @order.bt_payment_method_token = result.payment_method.token
      @order.save!

      redirect_to review_order_path(@order)
    else
      flash[:alert] = 'Unable to add payment info'

      render :add_payment
    end
  end

  def review
    @payment_method = Braintree::PaymentMethod.find(@order.bt_payment_method_token)
  end

  def confirm
    result = Braintree::Transaction.sale(
      amount: @order.amount,
      payment_method_token: @order.bt_payment_method_token
    )

    if result.success?
      @order.bt_transaction_id = result.transaction.id
      @order.save!

      redirect_to thankyou_order_path(@order)
    else
      flash[:alert] = "Unable to create order"

      render :review
    end
  end

  def thankyou
  end

  def accept
    # - Settle the order transaction
  end

  private

  def find_order
    @order = current_user.orders.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:name, :email, :address)
  end
end
