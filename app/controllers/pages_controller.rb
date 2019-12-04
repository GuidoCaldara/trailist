class PagesController < ApplicationController
  skip_before_action :authenticate_user!
  def home
    @races = Race.all.sample(3)
  end


  def policy
  end
end
