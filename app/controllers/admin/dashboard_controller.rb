class Admin::DashboardController < ApplicationController

  http_basic_authenticate_with name: ENV['ADMIN_USERNAME'], password: ENV['ADMIN_PASSWORD']

  def show
    @product_count = Product.all.size
    puts @product_count
    @categories_count = Category.all.size
    puts @categories_count
  end
end
