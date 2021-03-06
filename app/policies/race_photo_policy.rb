class RacePhotoPolicy < ApplicationPolicy

  def index?
    user_is_owner?
  end

  def create?
    user_is_owner?
  end

  def destroy?
    user_is_owner?
  end

private
  def user_is_owner?
    user.organization && user.organization.races.any? && user.organization.races.include?(record.race)
  end
end
