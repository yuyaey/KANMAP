FactoryBot.define do
  factory :kanzume do
    sequence(:name) { |n| "TestKanzume#{n}" } 
    association :kanzume_icon
    association :user
    after(:create) do |kanzume|
      kanzume.maps << FactoryBot.create(:map, address: "Tokyo")
    end

    trait :invalid do
      name { nil }
    end

    trait :forpost do
      kanzume_icon_id { 99 }
      map { 99 }
    end
  end
end
