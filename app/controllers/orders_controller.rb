class OrdersController < ApplicationController
  before_action :set_product, only: %i[ show ]

  # GET /orders
  def index
    @orders = current_user.orders

    render json: @orders
  end

  # GET /products/1
  def show
    render json: @order
  end

  # POST /orders
  def create
    @order = Order.new(user: current_user)

    if @order.save
      render json: @order, status: :created, location: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end
end
