class RacePhotosController < ApplicationController

  def index
    @race = Race.find(params[:race_id])
    @photos = @race.race_photos
    @photo = RacePhoto.new(race: @race)
    authorize @photo
  end

  def create
    @race = Race.find(params[:race_id])
    params[:race_photo][:picture].each do |photo|
      @photo = RacePhoto.new(picture: photo, race: @race)
      authorize @photo
      @photo.save
    end
    redirect_to race_race_photos_path(@race)
    flash[:succes] = "Le foto sono state caricate correttamente!"
  end

  def destroy
    @photo = RacePhoto.find(params[:id])
    authorize @photo
    @photo.destroy
    redirect_to race_race_photos_path(@photo.race)
  end
end
