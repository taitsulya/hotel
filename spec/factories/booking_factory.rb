# frozen_string_literal: true

FactoryBot.define do
  factory :booking do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    mobile_phone { Faker::PhoneNumber.phone_number }
    arrival { Faker::Date.forward(days: 100) }
    departure { Faker::Date.forward(days: 100) }
  end
end
