FactoryBot.define do
  factory :episode do
    name { FFaker::Skill.tech_skill }
    season { 1 }
    number { 2 }
    air_time { "9:00 PM" }
  end
end
