# frozen_string_literal: true

class ReviewPolicy < ApplicationPolicy
  def index?
    true
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
