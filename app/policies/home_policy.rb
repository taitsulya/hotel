# frozen_string_literal: true

class HomePolicy < ApplicationPolicy
  def index?
    true
  end

  def update?
    admin.present?
  end
end
