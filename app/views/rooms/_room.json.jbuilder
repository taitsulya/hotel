# frozen_string_literal: true

json.extract! room, :id, :name, :room_type, :price, :short_description, :full_description, :created_at, :updated_at
json.url room_url(room, format: :json)
