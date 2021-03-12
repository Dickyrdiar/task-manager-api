require "rails_helper"

RSpec.describe ApplicationCable::Connection, type: :channel do 
    context 'when user is auhtenticate' do
        let(:user) { create(:user) }
        let(:token) { user.create_new_auth_token } 
    end 
end 