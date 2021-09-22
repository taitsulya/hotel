# frozen_string_literal: true

class CsvJob < ApplicationJob
  queue_as :default

  def perform
    CsvGenerator.generate(Booking.where(actual: true))
  end
end
