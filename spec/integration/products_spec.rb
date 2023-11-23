# require 'swagger_helper'

# describe 'Products api' do
#   path '/products' do
#     get 'Get all products' do
#       tags 'Products'
#       consumes 'application/json'
#       produces 'application/json'

#       response '200', 'Fetch all Products' do
#         schema type: :array,
#          items: {
#            type: :object,
#            properties: {
#              id: { type: :integer },
#              name: { type: :string },
#              description: { type: :string },
#              price: { type: :double },
#              availability: { type: :boolean },
#              # Add more properties as needed
#            },
#            required: ["id", "patient_id", "provider_id"]
#          }
#         run_test!
#       end

#       response '422', 'invalid request' do
#         let(:Authorization) { 'Invalid' }
#         run_test!
#       end
#     end
#   end
# end