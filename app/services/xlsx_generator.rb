# frozen_string_literal: true

class XlsxGenerator
  class << self
    def generate(bookings)
      attributes = %w[name email mobile_phone arrival departure room_id created_at updated_at]
      xlsx_file = generate_file(bookings, attributes)

      file_name = 'bookings.xlsx'
      FileSaver.save(Rails.root.join('public/statistics'), file_name, xlsx_file)
      DbSaver.new('xlsx').save("/statistics/#{file_name}")
    end

    private

    def generate_file(records, attributes)
      package = Axlsx::Package.new do |p|
        wb = p.workbook
        wb.add_worksheet do |sheet|
          sheet.add_row %w[Total]
          sheet.add_row [records.count]
          sheet.add_row
          sheet.add_row attributes
          records.each do |record|
            sheet.add_row record.attributes.values_at(*attributes)
          end
        end
      end
      package.to_stream.read
    end
  end
end
