# frozen_string_literal: true

class Review < ApplicationRecord
  validates :author_name, presence: true
  validates :author_email, presence: true
  validates :body, presence: true

  scope :checked_and_sorted, -> { where(checked: true).order(created_at: :desc) }
end
