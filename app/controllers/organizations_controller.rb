class OrganizationsController < ApplicationController

  def organizer_dashboard
    @organization = current_user.organization
    @races = @organization.races
  end

  def add_your_group
  end
  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(organization_params)
    @organization.user = current_user
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

  def edit
    @organization = Organization.find(params[:id])
  end

  def update
    @organization = Organization.find(params[:id])
    if @organization.update(organization_params)
      redirect_to @organization
    else
      render 'edit'
    end
  end

  private

  def organization_params
    params.require(:organization).permit(:name, :email, :phone, :logo, :location, :description)
  end
end
