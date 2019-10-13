FactoryBot.define do
  factory :kanzume_icon do
      name { "TestKanzumeIcon" }
      picture {File.new("#{Rails.root}/spec/fixtures/crubcan.png")}
  end
end
