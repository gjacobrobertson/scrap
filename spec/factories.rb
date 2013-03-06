FactoryGirl.define do
  factory :user do
    name "Red Foo"
  end

  factory :transaction do
    association :from, factory: :user
    association :to, factory: :user, name: "Sky Bloo"
    amount 5
  end
end
