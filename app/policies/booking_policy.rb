# frozen_string_literal: true

class BookingPolicy < ApplicationPolicy
  def index?
    admin.present?
  end

  def show?
    admin.blank?
  end

  def create?
    admin.blank?
  end

  def update?
    admin.present?
  end

  def destroy?
    admin.present?
  end
end
