class PaymentsController < ApplicationController
  def create_payment_intent
    intent = Stripe::PaymentIntent.create(
      amount: amount,
      currency: 'usd',
      payment_method_types: ['card'],
      receipt_email: email,
      customer: create_stripe_customer(email, name)
    )

    # We can find the entry for intent object here https://dashboard.stripe.com/test/events
    render json: { client_secret: intent.client_secret }
  end

  private

  def amount
    params[:amount]
  end

  def email
    params[:email]
  end
  
  def name
    params[:name]
  end

  def create_stripe_customer(email, name)
    customer = Stripe::Customer.create(
      name: name,
      email: email,
      metadata:{
        name: name,
        email: email,
      }
    )
    customer.id
  end
end
