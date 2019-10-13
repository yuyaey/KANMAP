FactoryBot.define do
  factory :item do
    sequence(:name) { |n| "TestItem#{n}" }
    memo { "This is a test memo"}
    association :item_icon
    association :kanzume
    association :user

    trait :invalid do
      name { nil }
    end

    trait :forpost do
      kanzume_id { 99 }
      item_icon_id { 99 }
    end
  end
end
