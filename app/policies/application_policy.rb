# frozen_string_literal: true

class ApplicationPolicy
  attr_reader :admin, :record

  def initialize(admin, record)
    @admin = admin
    @record = record
  end

  def index?
    false
  end

  def show?
    false
  end

  def create?
    false
  end

  def new?
    create?
  end

  def update?
    false
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  class Scope
    def initialize(admin, scope)
      @admin = admin
      @scope = scope
    end

    def resolve
      scope.all
    end

    private

    attr_reader :admin, :scope
  end
end
