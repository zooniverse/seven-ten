FactoryGirl.define do
  factory :split do
    sequence :id
    project
    name{ "#{ project.slug }-split-#{ id }" }
    key{ "key.#{ name }" }

    factory :split_with_variants do
      transient do
        variant_count 2
      end

      after :create do |split, evaluator|
        create_list :variant, evaluator.variant_count, split: split
      end
    end
  end
end
