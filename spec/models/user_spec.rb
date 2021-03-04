require 'rails_helper'

RSpec.describe User, type: :model do
  
  it "should have email" do
    User.new(:email => "co.write@yahoo.com").should be_valid 
  end 

end
