FactoryGirl.define do
  factory :split do
    sequence :id
    project
    name{ "#{ project.slug }-split" }
  end
end
