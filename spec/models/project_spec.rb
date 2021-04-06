require 'rails_helper'
# require "action_cable/testing/rspec"

RSpec.describe Project, elasticsearch: true, type: :model do
  it 'should be indexed' do
    expect(Project.__elasticsearch__.indexed_exists?).to be_truthy 
  end 

  subject { Project.new(name: 'vinyard', desc: '18+company', date_begining: '14/05/2020') }

  before { subject.save }

  it 'name to be present' do 
    subject.name = nil 
    expect(subject).to_not be_valid 
  end 

  it 'desc should be present' do
    subject.desc = nil 
    expect(subject).to_not be_valid  
  end 

  it 'date_begining be present' do
    subject.date_begining = nil 
    expect(subject).to_not be_valid 
  end 
end
