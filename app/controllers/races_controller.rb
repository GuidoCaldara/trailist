class RacesController < ApplicationController
  before_action :set_race, only: [:show, :edit, :update, :destroy]
  skip_before_action :authenticate_user!, only: [:show, :index ]

  def index
    @races = Race.geocoded
    @races = @races.search_by_name(params[:name]) if params[:name].present?
    @races = @races.near(params[:location], 80) if params[:location].present?
    if params[:category].present? && !params[:category].include?("[")
      @races = @races.filter_by_type(params[:category])
    end
    @races = @races.filter_by_distance(params[:distance]) if params[:distance].present?
    if params[:dates].present?
      start_date = Date.parse(params[:dates].split(' ')[0])
      end_date = Date.parse(params[:dates].split(' ')[2])
      @races = @races.filter_by_date(start_date, end_date )
    end
    @markers = @races.map do |race|
      {
        race_id: race.id,
        lat: race.latitude,
        lng: race.longitude,
        infoWindow: render_to_string(partial: "race_info_window", locals: { race: race }),
        image_url: helpers.asset_url('map-marker.png')
      }
    end
    respond_to do |format|
      format.html { render 'index'}
      format.js
    end
  end

  def show
    authorize @race
    @coordinates = [{ lat: @race.latitude, lng: @race.longitude}]
    @reviews = @race.reviews.order(created_at: :desc)
    @review = Review.new
  end

  def new
    @race = Race.new
    authorize @race
  end

  def create
    @race = Race.new(race_params)
    authorize @race
    @race.organization = current_user.organization
    if @race.save
      flash[:success] = "La gara è stata inserita correttamente! Ora puoi aggiungere il prezzo dell'iscrizione e le fotografie!"
      redirect_to race_race_prices_path(@race)
    else
      render 'new'
    end
  end



  def edit
     authorize @race
  end

  def update
    @race = Race.friendly.find(params[:id])
    authorize @race
    if @race.update(race_params)
      flash[:success] = "La gara è stata aggiornata correttamente!"
      redirect_to @race
    else
      render 'new'
    end

  end

  private

  def set_race
    @race = Race.friendly.find(params[:id])
  end

  def race_params
    params.require(:race).permit(:name, :length, :elevation, :date, :departure_time, :description, :goodies, :location, :race_type, :video)
  end
end
