# frozen_string_literal: true

class CreateBookings < ActiveRecord::Migration[6.1]
  def change
    create_table :bookings do |t|
      t.string :name
      t.string :email
      t.string :mobile_phone
      t.date :arrival
      t.date :departure
      t.references :room, null: false, foreign_key: true
      t.boolean :actual, default: false

      t.timestamps
    end
  end
end
