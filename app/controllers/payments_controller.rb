class PaymentsController < ApplicationController
  def create_payment_intent
    intent = Stripe::PaymentIntent.create(
      amount: params[:amount],
      currency: 'usd'
    )

    # We can find the entry for intent object here https://dashboard.stripe.com/test/events
    render json: { client_secret: intent.client_secret }
  end
end
