# frozen_string_literal: true

class Image < ApplicationRecord
  belongs_to :room
  mount_uploader :room_image, RoomImageUploader
end
