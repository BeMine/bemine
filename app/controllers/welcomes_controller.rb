class WelcomesController < ApplicationController
  def index
    @categories = Category.all
  end
end
