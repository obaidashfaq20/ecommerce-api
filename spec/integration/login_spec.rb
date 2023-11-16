require 'swagger_helper'

describe 'login api' do
  path '/login' do
    post 'Create a session' do
      tags 'Devise Session'
      consumes 'application/json', 'application/xml'
      parameter email: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string, default: 'test@gmail.com' },
              password: { type: :string, default: 'Test@123' }
            },
            required: [ 'email', 'password' ]
          }
        },
        required: [ 'user' ]
      }

      response '200', 'devise session created' do
        let(:user) { { email: 'test@gmail.com', password: 'Test@123' } }
        run_test!
        header 'Authorization', type: :string
      end

      response '422', 'invalid request' do
        let(:user) { { email: 'test@example.com' } }
        run_test!
      end
    end
  end
end