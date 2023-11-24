class OrderItemsController < ApplicationController

  # GET /order_items
  def index
    @order_items = OrderItem.all

    render json: @order_items
  end

  def order_items
    @order = Order.find(params[:id])

    render json: @order.products
  end
end
