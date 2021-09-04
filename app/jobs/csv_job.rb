# frozen_string_literal: true

class CsvJob < ApplicationJob
  queue_as :default

  def perform(*args)
    records = args.first
    attributes = %w[name email mobile_phone arrival departure room_id created_at updated_at]
    CSV.generate(headers: true) do |csv|
      csv << ['Total']
      csv << [records.count]
      csv << []
      csv << attributes
      records.each do |booking|
        csv << booking.attributes.values_at(*attributes)
      end
    end
  end
end
