FactoryBot.define do
  factory :map do
    id { |n| "#{n}" }
    address { "Tokyo" } 
    latitude { "100" }
    longitude { "100" }
  end
end
