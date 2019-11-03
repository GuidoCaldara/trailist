class OrganizationsController < ApplicationController
  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_params)
    @organization.organizer = current_organizer
    if @organization.save
      flash[:success] = "La tua organizzazione è stata inserita!"
      redirect_to @organization
    else
      flash[:alert] = "Ops, c'è un errore nel form. Per favore controlla :)"
      render :new
    end
  end

  def show
    @organization = Organization.find(params[:id])
  end

  private

  def organization_params
    params.require(:organization).permit(:name, :email, :phone, :logo, :location, :description)
  end
end
