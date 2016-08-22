FactoryGirl.define do
  factory :metric do
    sequence :id
    key 'test'
    split_user_variant
  end
end
