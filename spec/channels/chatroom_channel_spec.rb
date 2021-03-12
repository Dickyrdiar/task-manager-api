require "rails_helper"

RSpec.describe ApplicationCable::ChatRoomChannel, :type => :channel do
   it "successfuly subscribes" do
    subscribe 
    
    perform :echo, foo: 'bar'
    expect(transmissions.last).to eq('foo' => 'bar')
   end 
end 