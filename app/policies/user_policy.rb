class UserPolicy < ApplicationPolicy

  def show?
    true
  end

  def complete_profile?
    user.username.nil?
  end

  def save_profile?
    user.username.nil?
  end

end
