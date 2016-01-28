class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_order, only: [:thank_you]

  def index
    @orders = current_user.orders.includes(line_item: :product)
  end

  def new
    if current_cart.empty?
      redirect_to root_path
    else
      @cart = current_cart
      @order = Order.build_from_cart(@cart, current_user)
      @payment_method = Braintree::PaymentMethod.find(current_cart.bt_payment_method_token)
    end
  end

  def create
    @order = Order.build_from_cart(current_cart, current_user)

    if @order.save
      session[:cart_id] = nil

      # TODO: Move to service object
      result = Braintree::Transaction.sale(
        amount: @order.amount,
        payment_method_token: current_cart.bt_payment_method_token
      )

      if result.success?
        @order.bt_transaction_id = result.transaction.id
        @order.save!

        User.notify_fulfiller!(@order)

        redirect_to thank_you_order_path(@order)
      else
        flash[:alert] = 'Unable to create a transaction'

        redirect_to root_path
      end
    else
      flash[:alert] = 'Unable to create a new order'

      render :new
    end
  end

  def thank_you
  end

  def show_acceptance
    # TODO: Move to before filter in acceptance controller
    @order = Order.find(params[:id])
    @fulfill_request = @order.fulfill_requests.find_by_token(params[:token])

    # TODO: Move if/else render login in view into view object
  end

  def update_acceptance
    # TODO: Consider resolving race condition using redis

    @order = Order.find(params[:id])
    @fulfill_request = FulfillRequest.find(params[:fulfill_request_id])

    return if @order.accepted?

    @order.fulfiller = @fulfill_request.user
    @order.save!

    # TODO: Move if/else render login in view into view object

    # TODO: Move mailing action to sidekiq
    UserMailer.notify_match_success(@order.fulfiller_id, @order).deliver_later!

    # TODO: redirect_to done_acceptance_order_path(@order)
  end

  private

  def find_order
    @order = current_user.orders.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:name, :fulfill_request, shipping_address_attributes:
                                  [:address1, :address2, :address3, :locality,
                                   :region, :postcode, :country])
  end
end
