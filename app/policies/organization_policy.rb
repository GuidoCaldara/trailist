class OrganizationPolicy < ApplicationPolicy

  def show?
    true
  end

  def organizer_dashboard?
    user.organization == record
  end

  def add_your_group?
    user.organization.nil?
  end

  def create?
    user.organization.nil?
  end

  def update?
    user.organization == record
  end

  def destroy?
    user.organization == record
  end
end
