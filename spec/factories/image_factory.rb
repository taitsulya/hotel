# frozen_string_literal: true

FactoryBot.define do
  factory :image do
    room_image { Faker::LoremFlickr.image }
  end
end
