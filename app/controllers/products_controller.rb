class ProductsController < ApplicationController

def index
  @category = Category.find(params[:category_id])
  @products = @category.products
  @product = Product.new
  
  #@products = Product.page( params[:page] ).per(4)
end


def new
  @category = Category.find(params[:category_id])
  @product =  @category.products.build	

end

def create
  @category = Category.find(params[:category_id])
  @product = @category.products.build(product_params)

  if @product.save
  	  flash[:notice] = "GREEN LIGHT"
        redirect_to category_products_path(@category)
      else
        render :action => "new"
    
  end
end

def show
  @category = Category.find(params[:category_id])
  @product = @category.products.find(params[:id]) 

end

def edit
  @category = Category.find(params[:category_id])
  @product = @category.products.find(params[:id]) 
end

def update
  @category = Category.find(params[:category_id])
  @product = @category.products.find(params[:id])

  if @product.update(product_params)
    UserMailer.notify_product(current_user, @product).deliver_later!
  	flash[:notice] = "編輯成功"
  	redirect_to category_products_path(@category)
  else
  	render :action => "edit"
  end


end

def destroy
  @category = Category.find(params[:category_id])
  @product = Product.find( params[:id] )
  @product.delete

  flash[:alert] = "刪除成功"

  redirect_to category_products_path
   
end	

def match
  
  @product = Product.find(params[:id])

  User.all.each do |u|
    if u != current_user

    UserMailer.notify_match(u, @product).deliver_later!

   end
    
  
    
 end

end

end



private
 def product_params
   params.require(:product).permit(:name, :description, :location, :price, :picture, :matcharea )

 end