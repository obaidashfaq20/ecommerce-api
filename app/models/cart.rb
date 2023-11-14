class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items

  def products
    products = []
    cart_items.each do |cart_item|
      products << cart_item.product
    end
    products
  end
end
