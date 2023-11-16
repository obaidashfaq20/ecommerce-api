# Note Swagger
After adding spec run the following command to reflect changes in api-docs
```
rails rswag:specs:swaggerize
```

# Note Stripe
After adding stripe gem run irb to test the following
```
> irb
require 'stripe'

Stripe.api_key = 'sk_test_123...'
Stripe::Customer.list()
```

# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

# Commands
1. rails new ecommerce-api --api –d postgresql --skip-test