# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :split_transaction do
    association :split, factory: :split
    association :from, factory: :user
    association :to, factory: :user, name: "Sky Bloo"
    amount 3.50
  end
end
