class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @orders = current_user.orders
  end

  def new
    @order = Order.new
    @order.name = current_user.name
    @order.email = current_user.email
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    @order.amount = current_cart.line_item.amount

    if @order.save
      session[:cart_id] = nil
      current_cart.line_item.update(order_id: @order.id)

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
