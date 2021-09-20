# frozen_string_literal: true

class CreateStatistics < ActiveRecord::Migration[6.1]
  def change
    create_table :statistics do |t|
      t.string :format
      t.string :path

      t.timestamps
    end
  end
end
