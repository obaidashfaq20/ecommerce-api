# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

test_user = User.create(name: 'test account', email: 'test@gmail.com', password: 'Test@123')
test_cart = Cart.create(user_id: test_user.id)

(0..10).each do |i|
  product = Product.new
  product.name = "product name: #{i}"
  product.description = "product description: #{i}"
  product.price = i * 3212
  product.availability = i%2 == 0
  product.save
end

cart_item = CartItem.create(product: Product.last, cart: Cart.last)
cart_item = CartItem.create(product: Product.second, cart: Cart.last)
