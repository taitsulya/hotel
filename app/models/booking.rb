# frozen_string_literal: true

class Booking < ApplicationRecord
  belongs_to :room

  validates :name, presence: true
  validates :email, presence: true
  validates :mobile_phone, presence: true
end
