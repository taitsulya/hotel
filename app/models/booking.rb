# frozen_string_literal: true

class Booking < ApplicationRecord
  belongs_to :room

  validates :name, :email, :mobile_phone, presence: true

  def self.to_csv
    CsvJob.new.perform(all)
  end

  def self.to_xlsx
    XlsxJob.new.perform(all)
  end
end
