# frozen_string_literal: true

class DbSaver
  def initialize(format)
    @format = format
  end

  def save(path)
    Statistic.find_by(format: @format) ? update_record : create_record(path)
  end

  def create_record(path)
    Statistic.create(format: @format, path: path)
  end

  def update_record
    Statistic.find_by(format: @format).update(updated_at: DateTime.now)
  end
end
