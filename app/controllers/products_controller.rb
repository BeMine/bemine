class ProductsController < ApplicationController
  before_action :new_product, only: [:new]
  before_action :find_product, only: [:show, :edit, :update, :destroy, :buy, :cancel, :match]

  def index
    @products = Product.all
  end

  def new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      flash[:notice] = '新增成功'
      redirect_to products_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @product.update(product_params)
      

      flash[:notice] = '編輯成功'
      redirect_to products_path
    else
      render :edit
    end
  end

  def destroy
    @product.delete

    flash[:alert] = '刪除成功'
    redirect_to products_path
  end

  def buy
    quantity = params[:quantity].to_i

    # Update line item in cart
    # extract = current_cart.add(product, quantity)
    if current_cart.line_item
      current_cart.line_item.update!(product: @product, quantity: quantity)
    else
      current_cart.create_line_item!(cart: current_cart, product: @product, quantity: quantity)
    end

    respond_to do |format|
      format.html { redirect_to show_address_cart_path(current_cart), notice: '加入成功' }
      format.js
    end
  end

  def cancel
    current_cart.line_item.destroy

    respond_to do |format|
      format.html { redirect_to products_path, notice: '移除成功' }
      format.js { render :buy }
    end
  end

  private

  def new_product
    @product = Product.new
  end

  def find_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :location, :price, :picture, :matcharea)
  end
end
