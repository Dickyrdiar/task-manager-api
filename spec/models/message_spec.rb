require 'rails_helper'

RSpec.describe Message, type: :model do
  subject { Message.new(text: 'project start at 5 pm') }

  before { subject.save }

  it 'text should be present' do
    subject.name = nil 
    expect(subject).not_to be_valid 
  end 
end
