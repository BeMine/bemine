class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new( category_params )

    if @category.save
      flash[:notice] = "GREEN LIGHT"
      redirect_to categories_path
    else
      render :action => :new
    end
  end

  def show
    @category = Category.find(params[:id])
    @products = @category.products
  end

  private

  def category_params
    params.require(:category).permit(:name, :description, :location, :price, :picture )
  end
end
