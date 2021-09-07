# frozen_string_literal: true

FactoryBot.define do
  factory :home do
    description { Faker::Lorem.paragraphs }
  end
end
