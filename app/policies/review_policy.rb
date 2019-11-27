class ReviewPolicy < ApplicationPolicy

  def create?
    user && Review.where(race: record.race, user: user).empty?
  end
end
