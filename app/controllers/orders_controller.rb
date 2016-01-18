class OrdersController < ApplicationController
  before_action :authenticate_user!

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

      User.all.each do |u|
        if u != current_user
          UserMailer.notify_match(u, current_cart.line_item.product).deliver_later!
        end
      end

      redirect_to orders_path
    else
      flash[:alert] = '新增失敗'

      render :new
    end
  end

  private

  def order_params
    params.require(:order).permit(:name, :email, :address)
  end
end
