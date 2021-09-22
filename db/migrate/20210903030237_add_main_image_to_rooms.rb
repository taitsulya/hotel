# frozen_string_literal: true

class AddMainImageToRooms < ActiveRecord::Migration[6.1]
  def change
    add_column(:rooms, :main_image_url, :string)
  end
end
