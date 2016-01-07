class DetailsController < ApplicationController

  def index
     @product = Product.find(params[:product_id])
     @details = @product.details
     @detail =  Detail.new
 

  end






end
