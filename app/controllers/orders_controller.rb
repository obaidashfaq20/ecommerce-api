class OrdersController < ApplicationController
  # GET /carts
  def index
    @orders = current_user.orders

    render json: @orders
  end
end
