class Admin::DashboardController < ApplicationController

  http_basic_authenticate_with name: ENV["USERNAME"], password: ENV["PASSWORD"]
  
  def show
    @products = Product.all.count
    @categories = Category.all.count
  end
end
