FactoryGirl.define do
  factory :split do
    with {[
      FactoryGirl.create(:user),
      FactoryGirl.create(:user)
    ]}
    amount 10.50
  end
end
