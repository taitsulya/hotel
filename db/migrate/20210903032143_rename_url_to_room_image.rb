# frozen_string_literal: true

class RenameUrlToRoomImage < ActiveRecord::Migration[6.1]
  def change
    rename_column(:images, :url, :room_image)
  end
end
