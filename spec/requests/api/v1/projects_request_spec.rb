require 'rails_helper'

RSpec.describe "Api::V1::Projects", type: :request do
    describe "POST /api/v1/projects" do
        context "with valid parameters" do
            let(:valid_params) do
                {
                    name: 'vinyard', 
                    desc: 'vinyard alcohol'
                } 
            end  

            it "create new project" do
                expect { post "api/v1/projecs", params: valid_params }.to change(Project, :count).by(+1)
                expect(reponse).to have_http_status :created 
                expect(response.headers['Location']).to eq api_v1_project_url(Project.last) 
            end 
        end  
    end 
end
