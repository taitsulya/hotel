# frozen_string_literal: true

class RenameTypeColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :rooms, :type, :room_type
  end
end
