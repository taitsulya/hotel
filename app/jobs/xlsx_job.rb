# frozen_string_literal: true

class XlsxJob < ApplicationJob
  queue_as :default

  def perform(*args)
    records = args.first
    package = Axlsx::Package.new do |p|
      wb = p.workbook
      wb.add_worksheet(name: 'booking') do |sheet|
        sheet.add_row %w[Total]
        sheet.add_row [records.count]
        sheet.add_row
        sheet.add_row %w[name email mobile_phone arrival departure room_id created_at updated_at]
        records.each do |booking|
          sheet.add_row [booking.name, booking.email, booking.mobile_phone, booking.arrival, booking.departure,
                         booking.room_id, booking.created_at, booking.updated_at]
        end
      end
    end
    package.to_stream.read
  end
end
