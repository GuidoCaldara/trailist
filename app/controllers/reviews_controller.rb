class ReviewsController < ApplicationController
  def create
    @review = Review.new(review_params)
    @race = Race.friendly.find(params[:race_id])
    @review.user = current_user
    @review.race = @race
    authorize @review
    if @review.save
      redirect_to @race
    else
      render 'races/show'
      flash[:success] = "La tua recensione è stata inserita correttamente!"
    end
  end

  def review_params
    params.require(:review).permit(:track, :organization, :difficulty, :recomandation, :content, :partecipation_year)
  end
end
