# frozen_string_literal: true

class Room < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :images, dependent: :destroy

  validates :name, :room_type, :price, :short_description, :full_description, presence: true

  mount_uploader :main_image, MainImageUploader
end
