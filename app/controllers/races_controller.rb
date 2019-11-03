class RacesController < ApplicationController
  before_action :set_race, only: [:show, :edit, :update, :destroy]

  def index
  end

  def show
  end

  def new
    @race = Race.new
  end

  def create
    @race = Race.new(race_params)
    @race.organization = current_organizer.organization
    if @race.save
      flash[:success] = "La gara è stata inserita!"
      redirect_to race_race_prices_path(@race)
    else
      flash[:alert] = "Ops, c'è un errore nel form. Per favore controlla e correggi :)"
      render :new
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
