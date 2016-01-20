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
          token = SecureRandom.hex(10)
          fulfill_request = u.fulfill_requests.build(:user => u, :order => @order, :token => token)
          UserMailer.notify_match(u, @order, current_cart.line_item.product, token).deliver_later!
          fulfill_request.save
          
        end
      end

      redirect_to orders_path
    else
      flash[:alert] = '新增失敗'

      render :new
    end
  end

  def accept
    @order = Order.find(params[:id])
    @fulfill_request = FulfillRequest.find_by_token(params[:token]).id
    
    

    


     #if @order.fulfiller_id == FulfillRequest.where("user_id = ? AND order_id = ?", current_user.id, @order.id).first.token
     #@status = true
    #end
    
  end 
    
  

  def orderconfirm
    @order = Order.find(params[:id])
    
    @fulfill_request = FulfillRequest.find(params[:fulfill_request]).user_id
    if @order.fulfiller_id.nil?
       UserMailer.notify_matchsuccess(@order.fulfiller_id,@product,@order).deliver_later!
       @order.fulfiller_id = @fulfill_request
       @order.save       
       
       
    end
      
  end
  

  private

  def order_params
    params.require(:order).permit(:name, :email, :address, :fulfill_request)
  end
end
