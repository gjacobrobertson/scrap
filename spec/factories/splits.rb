FactoryGirl.define do
  factory :split do
    with {[
      FactoryGirl.create(:user).uid,
      FactoryGirl.create(:user).uid
    ].join(',')}
    amount 10.50
  end
end
