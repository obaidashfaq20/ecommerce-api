class CartItemsController < ApplicationController
  before_action :set_cart_item, only: %i[ show update ]

  # GET /cart_items
  def index
    @cart_items = CartItem.all

    render json: @cart_items
  end

  # GET /cart_items/1
  def show
    render json: @cart_item
  end

  # POST /cart_items
  def create
    @cart_item = CartItem.new(cart_item_params)

    if @cart_item.save
      render json: @cart_item, status: :created, location: @cart_item
    else
      render json: @cart_item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cart_items/1
  def update
    if @cart_item.update(cart_params)
      render json: @cart_item
    else
      render json: @cart_item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cart_items/1
  def destroy
    product = Product.find(params[:id])
    cart_item = CartItem.find_by(product_id: product.id)
    cart_item.destroy
  end

  # POST /cart_items/add_to_cart/:product_id
  def add_to_cart
    product = Product.find(params[:product_id])

    if current_user.cart.nil?
      # create cart
      Cart.create!(user: current_user)
    end

    cart_item = CartItem.new(product_id: product.id, cart: current_user.cart)
    if cart_item.save
      render json: cart_item, status: :created, location: cart_item
    else
      render json: cart_item.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart_item
      @cart_item = CartItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cart_item_params
      params.require(:cart).permit(:card_id, :product_id, :quantity)
    end
end
