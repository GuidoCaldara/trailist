class RacesController < ApplicationController
  before_action :set_race, only: [:show, :edit, :update, :destroy]

  def index
    @races = Race.all
    @races = @races.search_by_name(params[:name]) if params[:name].present?
    @races = @races.near(params[:location]) if params[:location].present?
    @races = @races.filter_by_type(params[:category]) if params[:category].present?
    @races = @races.filter_by_distance(params[:distance]) if params[:distance].present?
    if params[:dates].present?
      start_date = Date.parse(params[:dates].split(' ')[0])
      end_date = Date.parse(params[:dates].split(' ')[2])
      @races = @races.filter_by_date(start_date, end_date )
    end
    @markers = @races.map do |race|
      { lat: race.latitude, lng: race.longitude }
    end
    respond_to do |format|
      format.html { render 'index'}
      format.js
    end
  end

  def show
    @coordinates = [@race.latitude, @race.longitude]
    @review = Review.new
  end

  def new
    @race = Race.new
  end

  def create
    @race = Race.new(race_params)
    byebug
    @race.organization = current_user.organization
    if @race.save
      redirect_to race_race_prices_path(@race)
    else
      render 'new'
    end
    # respond_to do |format|
    #   format.html
    #   format.js
    # end
  end

  def update_description
    @race = Race.find(params[:id])
    @race.update = (race_params)
    respond_to do |format|
      format.html
      format.js
    end
  end



  def edit
  end

  private

  def set_race
    @race = Race.find(params[:id])
  end

  def race_params
    params.require(:race).permit(:name, :length, :elevation, :date, :departure_time, :description, :goodies, :location, :race_type, :video)
  end
end
