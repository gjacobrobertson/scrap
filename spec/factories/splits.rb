# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :split do
    from "Red Foo"
    with ["Sky Bloo", "Foo Bar"]
    amount 7.00
  end
end
