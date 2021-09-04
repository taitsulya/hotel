# frozen_string_literal: true

class Booking < ApplicationRecord
  belongs_to :room

  validates :name, presence: true
  validates :email, presence: true
  validates :mobile_phone, presence: true

  def self.to_csv
    CsvJob.new.perform(all)
  end

  def self.to_xlsx
    XlsxJob.new.perform(all)
  end
end
