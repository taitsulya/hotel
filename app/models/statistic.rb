# frozen_string_literal: true

class Statistic < ApplicationRecord
  validates :format, presence: true
end
