class Review < ApplicationRecord
  belongs_to :race
  belongs_to :user


  def rating_to_star

  end
end
