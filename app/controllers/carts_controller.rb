class CartsController < ApplicationController
  before_action :authenticate_user!

  def show_address
    @cart = current_cart
    @cart.setup_for_checkout(current_user)
  end

  def update_address
    @cart = current_cart
    @cart.update(cart_params)

    if current_cart.save
      redirect_to show_payment_cart_path(@cart)
    else
      render :show_address
    end
  end

  def show_payment
    @cart = current_cart
    user = current_user

    # TODO: Move to service object
    if user.bt_customer_id.nil?
      result = Braintree::Customer.create
      user.bt_customer_id = result.customer.id
      user.save!
    end

    @bt_client_token = Braintree::ClientToken.generate(customer_id: user.bt_customer_id)
  end

  def update_payment
    nonce = params[:payment_method_nonce]

    result = Braintree::PaymentMethod.create(
      customer_id: current_user.bt_customer_id,
      payment_method_nonce: nonce
    )

    if result.success?
      current_cart.bt_payment_method_token = result.payment_method.token
      current_cart.save!

      redirect_to new_order_path
    else
      flash[:alert] = 'Unable to add payment info'

      render :show_payment
    end
  end

  private

  def cart_params
    params.require(:cart).permit(:name, shipping_address_attributes:
                                 [:address1, :address2, :address3, :locality,
                                  :region, :postcode, :country])
  end
end
