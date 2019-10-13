FactoryBot.define do
  factory :user do
      name { "TestUser" }
      sequence(:email) { |n| "tester#{n}@example.com" }
      password { "password" }
  end
end
