# frozen_string_literal: true

class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.string :author_name
      t.string :author_email
      t.text :body
      t.boolean :checked, default: false

      t.timestamps
    end
  end
end
