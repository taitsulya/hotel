# frozen_string_literal: true

class XlsxJob < ApplicationJob
  queue_as :default

  def perform
    XlsxGenerator.generate(Booking.where(actual: true))
  end
end
