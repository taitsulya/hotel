# frozen_string_literal: true

class Review < ApplicationRecord
  validates :author_name, :author_email, :body, presence: true
end
