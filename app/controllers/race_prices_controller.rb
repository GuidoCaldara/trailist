class RacePricesController < ApplicationController
  def index
    @race = Race.friendly.find(params[:race_id])
    @prices = @race.race_prices
    @price = RacePrice.new(race: @race)
    authorize @price
  end

  def create
    @race = Race.friendly.find(params[:race_id])
    @price = RacePrice.new(race: @race, price: params[:race_price][:price])
    @price.start_date = params[:race_price][:start_date].split(" ")[0]
    @price.end_date = params[:race_price][:start_date].split(" ")[2]
    @price.save
    authorize @price
    respond_to do |format|
      format.html { render "races/show" }
      format.js
    end
  end

  def destroy
    @price = RacePrice.find(params[:id])
    authorize @price
    @price.destroy
    redirect_to race_race_prices_path(@price.race)
  end
end
