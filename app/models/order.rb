class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  enum status: { pending: 0, processing: 1, completed: 2}

  def products
    products = []
    order_items.each do |order_item|
      products << order_item.product
    end
    products
  end
end
