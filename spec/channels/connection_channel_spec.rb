require "rails_helper"

RSpec.describe ApplicationCable::Connection, type: :channel do 
    it "successfuly connect" do
        connect "api/v1/cable", headers: { "X-USER-ID" => "325" }
        expect(connecttion.user_id).to eq "325"

        it "reject connection" do
            expect { connect "/cable" }.to have_rejected_connection 
        end 
    end 
end 