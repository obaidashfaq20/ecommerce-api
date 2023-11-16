class Product < ApplicationRecord
  has_many :cart_items

  scope :in_stock, -> { where(availability: true) }
  scope :out_of_stock, -> { where(availability: false) }
end
