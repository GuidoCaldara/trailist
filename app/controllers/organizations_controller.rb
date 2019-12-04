class OrganizationsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show]

  def organizer_dashboard
    @organization = current_user.organization
    authorize @organization
    @races = @organization.races
  end

  def add_your_group
    authorize Organization.new
  end

  def new
    @organization = Organization.new
    authorize @organization
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
    @organization = Organization.friendly.find(params[:id])
    authorize @organization
  end

  def edit
    @organization = Organization.friendly.find(params[:id])
    authorize @organization
  end

  def update
    @organization = Organization.friendly.find(params[:id])
    authorize @organization
    if @organization.update(organization_params)
      redirect_to @organization
    else
      render 'edit'
    end
  end

  private

  def organization_params
    params.require(:organization).permit(:name, :email, :phone, :logo, :location, :website, :description)
  end
end
