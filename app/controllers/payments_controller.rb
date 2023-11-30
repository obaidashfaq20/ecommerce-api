class PaymentsController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:stripe_webhook]

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

  def stripe_webhook
    endpoint_secret = ENV['STRIPE_WEBHOOK_SECRET']

    payload = request.body.read
    sig_header = request.headers['HTTP_STRIPE_SIGNATURE']
    event = nil

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, endpoint_secret
      )
    rescue JSON::ParserError => e
      # Invalid payload
      render json: { error: { message: e.message }}, status: :bad_request
      return
    rescue Stripe::SignatureVerificationError => e
      # Invalid signature
      render json: { error: { message: e.message, extra: "Sig verification failed" }}, status: :bad_request
      return
    end

    # Handle the event
    case event.type
    when 'payment_intent.created'
      handle_payment_intent_created(event)
    when 'payment_intent.succeeded'
      handle_payment_intent_succeeded(event)
    when 'payment_method.attached'
      handle_payment_intent_attached(event)
    else
      puts "Unhandled event type: #{event.type}"
    end

    render json: { message: :success }
  end

  private

  def handle_payment_intent_succeeded(event)
    payment_intent = event.data.object # contains a Stripe::PaymentIntent
    # update_order_status_to_completed
    order = Order.find_by(payment_intent_id: payment_intent.id)
    order.completed!
    puts 'PaymentIntent was successful!'
  end

  def handle_payment_intent_created(event)
    # update_order_status_to_processing
    payment_intent = event.data.object # contains a Stripe::PaymentIntent
    puts 'PaymentIntent was created!'
  end

  def handle_payment_intent_attached(event)
    payment_method = event.data.object # contains a Stripe::PaymentMethod
    puts 'PaymentMethod was attached to a Customer!'
    # ... handle other event types
  end

  def amount
    params[:amount]
  end

  def email
    params[:email]
  end
  
  def name
    params[:name]
  end

  def order_id
    params[:order_id]
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
