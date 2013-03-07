FactoryGirl.define do
  sequence :name do |n|
    "#{Faker::Name::first_name} #{Faker::Name::last_name}"
  end
  factory :user do
    name
  end
end
