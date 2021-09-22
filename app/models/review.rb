# frozen_string_literal: true

class Review < ApplicationRecord
  validates :author_name, :author_email, :body, presence: true

  scope :checked_and_sorted, -> { where(checked: true).order(created_at: :desc) }
end
