# frozen_string_literal: true

class CsvGenerator
  class << self
    def generate(bookings)
      attributes = %w[name email mobile_phone arrival departure room_id created_at updated_at]
      csv_file = generate_file(bookings, attributes)

      file_name = 'bookings.csv'
      FileSaver.save(Rails.root.join('public/statistics'), file_name, csv_file)
      DbSaver.new('csv').save("/statistics/#{file_name}")
    end

    private

    def generate_file(records, attributes)
      CSV.generate(headers: true) do |csv|
        csv << ['Total']
        csv << [records.count]
        csv << []
        csv << attributes
        records.each do |record|
          csv << record.attributes.values_at(*attributes)
        end
      end
    end
  end
end
