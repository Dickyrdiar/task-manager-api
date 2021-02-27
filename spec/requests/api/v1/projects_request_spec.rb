require 'rails_helper'

RSpec.describe "Api::V1::Projects", type: :request do
    it "create A project" do 
        headers = { "ACCEPT" => "application/json" }
        post "/proejcts", :params => { :project => {:name => "my Project"} }, 
        
        expect(response.content_type).to ("application/json")
        expect(response).to have_http_status(:created)
    end 
end
