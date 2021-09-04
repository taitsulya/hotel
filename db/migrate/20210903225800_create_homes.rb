# frozen_string_literal: true

class CreateHomes < ActiveRecord::Migration[6.1]
  def change
    create_table :homes do |t|
      t.text :description

      t.timestamps
    end
  end
end
