require 'swagger_helper'

describe 'login api' do
  path '/login' do
    post 'Create a session' do
      tags 'Devise Session'
      consumes 'application/json', 'application/xml'
      parameter email: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        
        },
        required: [ 'email', 'password' ]
      }

      response '201', 'devise session created' do
        let(:user) { { email: 'test@gmail.com', password: 'Test@123' } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:user) { { email: 'test@example.com' } }
        run_test!
      end
    end
  end
end