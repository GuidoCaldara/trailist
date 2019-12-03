class ReviewPolicy < ApplicationPolicy

  def create?
    user && Review.where(race: record.race, user: user).empty? && user.organization != record.race.organization
  end
end
