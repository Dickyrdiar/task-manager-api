require 'rails_helper'

# RSpec.describe "Api::Auth::Users", type: :request do
#     it ""

# end

describe 'Users API', type: :request do
    it 'returns all users' do
        get 'api/auth/users'
        
        expect(response).to have_htttp_status(:success)
        expect(JSON.parse(response.body).size).to eq(2)
    end  
end 
