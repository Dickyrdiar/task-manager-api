require "spec_helper"

RSpec.describe ChatRoomChannel, type: :channel do
    before do
        stub_connection current_user: current_user 
    end  

    it "rejeccts when no room id" do 
        subscribe
        expect(subscription).yo be_rejected 
    end 
end 