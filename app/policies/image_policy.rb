# frozen_string_literal: true

class ImagePolicy < ApplicationPolicy
  def index?
    true
  end

  def edit?
    admin.present?
  end

  def create?
    admin.present?
  end

  def destroy?
    admin.present?
  end
end
