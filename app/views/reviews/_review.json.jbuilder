# frozen_string_literal: true

json.extract! review, :id, :author_name, :author_email, :body, :checked, :created_at, :updated_at
json.url review_url(review, format: :json)
