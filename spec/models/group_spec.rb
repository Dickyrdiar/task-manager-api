require 'rails_helper'

RSpec.describe Group, type: :model do
  subject { Group.new(name: 'orang tua', desc: 'company production wine') }

  before { subject.save }

  it 'name should be present' do
    subject.name = nil 
    expect(subject).to_not be_valid 
  end 
end
