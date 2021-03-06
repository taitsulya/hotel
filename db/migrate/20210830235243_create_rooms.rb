# frozen_string_literal: true

class CreateRooms < ActiveRecord::Migration[6.1]
  def change
    create_table(:rooms) do |t|
      t.string(:name)
      t.string(:type)
      t.decimal(:price)
      t.string(:short_description)
      t.text(:full_description)

      t.timestamps
    end
  end
end
