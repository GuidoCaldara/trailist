class UserPolicy < ApplicationPolicy

  def show?
    true
  end

  def update?
    record == user
  end

  def complete_profile?
    user.username.nil?
  end

  def save_profile?
    user.username.nil?
  end
end
