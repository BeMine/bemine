class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def cart
    cart = Cart.find_by(id: session[:cart_id]) if session[:cart_id]

    if cart.nil?
      cart = Cart.create!
      session[:cart_id] = cart.id
    end

    return cart
  end

  def current_cart
    @current_cart = cart unless @current_cart

    return @current_cart
  end

  helper_method :current_cart
end
