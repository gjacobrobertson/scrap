FactoryGirl.define do
  sequence :name do |n|
    "#{Faker::Name::first_name} #{Faker::Name::last_name}"
  end
  sequence :uid do |n|
    rand(99999999)
  end
  factory :user do
    name
    uid
  end
end
