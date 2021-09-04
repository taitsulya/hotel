# frozen_string_literal: true

class RoomPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    admin.present?
  end

  def update?
    admin.present?
  end

  def destroy?
    admin.present?
  end

  def delete_image?
    admin.present?
  end
end
