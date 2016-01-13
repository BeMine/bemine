class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :edit, :update, :destroy, :buy, :cancel]

  def index
    @products = Product.all
    @product = Product.new
  end

  def new
    @product =  @category.products.build
  end

  def create
    @product = @category.products.build(product_params)

    if @product.save
      flash[:notice] = "新增成功"
      redirect_to category_products_path(@category)
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
      flash[:notice] = "編輯成功"
      redirect_to category_products_path(@category)
    else
      render :edit
    end
  end

  def destroy
    @product.delete

    flash[:alert] = "刪除成功"

    redirect_to category_products_path
  end

  def buy
    # Add to cart
    current_cart.add_line_item(@product)

    respond_to do |format|
      format.html {
        flash[:notice] = "加入成功"
        redirect_to :back
      }
      format.js
    end
  end

  def cancel
    line_item = current_cart.line_items.find_by( :product_id => @product.id )
    line_item.destroy

    respond_to do |format|
      format.html {
        flash[:notice] = "移除成功"
        redirect_to :back
      }
      format.js { render "buy" }
    end
  end

  private

  def find_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :location, :price, :picture, :matcharea)
  end
end
