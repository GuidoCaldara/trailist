class ReviewPolicy < ApplicationPolicy

  def create?
    Review.where(race: record.race, user: user).empty?
  end
end
