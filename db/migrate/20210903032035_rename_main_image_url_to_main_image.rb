# frozen_string_literal: true

class RenameMainImageUrlToMainImage < ActiveRecord::Migration[6.1]
  def change
    rename_column :rooms, :main_image_url, :main_image
  end
end
