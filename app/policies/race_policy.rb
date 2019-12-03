class RacePolicy < ApplicationPolicy

  def show?
    true
  end

  def new?
    user.organization
  end

  def create?
    user.organization == record.organization
  end

  def update?
    record.organization == user.organization
  end

  def destroy?
    record.organization == user.organization
  end
end
