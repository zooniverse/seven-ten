FactoryGirl.define do
  factory :split do
    sequence :id
    project
    name{ "#{ project.slug }-split" }
    key{ "key.#{ name }" }
  end
end
