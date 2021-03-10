class Admin::DashboardController < ApplicationController

  before_filter :authorize

  http_basic_authenticate_with name: ENV["ADMIN"], password: ENV["PASSWORD"]

  def show
    @product_count = Product.count(created_at: :desc)
    @category_count = Category.count(created_at: :desc)
  end
end