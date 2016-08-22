FactoryGirl.define do
  factory :split_user_variant do
    sequence :id
    split
    user
    variant
  end
end
