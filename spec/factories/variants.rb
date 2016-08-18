FactoryGirl.define do
  factory :variant do
    sequence :id
    split
    name{ id.to_s }
    value text: 'test'
  end
end
