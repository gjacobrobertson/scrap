FactoryGirl.define do
  factory :transaction do
    association :from, factory: :user
    association :to, factory: :user, name: "Sky Bloo"
    amount 3.50
  end
end
