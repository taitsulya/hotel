# frozen_string_literal: true

FactoryBot.define do
  factory :room do
    name { Faker::Name.name }
    room_type { Faker::Lorem.word }
    price { Faker::Number.number }
    short_description { Faker::Lorem.paragraph }
    full_description { Faker::Lorem.paragraphs }
  end
end
