FactoryGirl.define do
  factory :split do
    from { FactoryGirl.create(:user).id }
    with {[
      FactoryGirl.create(:user).id,
      FactoryGirl.create(:user).id
    ]}
    amount 10.50
  end
end
