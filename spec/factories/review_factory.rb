# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    author_name { Faker::Name.name }
    author_email { Faker::Internet.email }
    body { Faker::Lorem.paragraphs }
  end
end
