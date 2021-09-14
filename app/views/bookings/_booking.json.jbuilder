# frozen_string_literal: true

json.extract!(booking, :id, :name, :email, :mobile_phone, :arrival, :departure, :room_id, :actual, :created_at,
              :updated_at)
json.url(booking_url(booking, format: :json))
