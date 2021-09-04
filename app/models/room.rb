# frozen_string_literal: true

class Room < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :images, dependent: :destroy

  validates :name, presence: true
  validates :room_type, presence: true
  validates :price, presence: true
  validates :short_description, presence: true
  validates :full_description, presence: true

  mount_uploader :main_image, MainImageUploader
end
