FactoryGirl.define do
  factory :variant do
    sequence :id
    split
    name{ id.to_s }
    key{ "key.#{ name }" }
    value text: 'test'
  end
end
