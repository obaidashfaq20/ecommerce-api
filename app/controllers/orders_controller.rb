class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show ]

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
    @order = Order.new(user: current_user, payment_intent_id: payment_intent_id)

    if @order.save
      create_order_items(@order)
      render json: @order, status: :created, location: @order
    else
      render json: @order.errors, status: :unprocessable_entity
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def cart_items
    params[:cartItems]
  end

  def payment_intent_id
    params[:payment_intent_id]
  end

  def create_order_items(order)
    order.processing!
    cart_items.each do |product|
      order.order_items.create!(product_id:product[:id])
    end
  end
end
