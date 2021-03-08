# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :authentication_token do
    body "MyString"
    user nil
    last_used_at "2021-03-07 13:30:00"
    ip_address "MyString"
    user_agent "MyString"
  end
end
