# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :notification do
    user ""
    recipient_id 1
    action "MyString"
    notifiable_type "MyString"
    notifiable_id 1
  end
end
