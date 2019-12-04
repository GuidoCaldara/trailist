class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :store_user_location!, if: :storable_location?
  before_action :profile_completed?
  before_action :authenticate_user!
  include Pundit

  # Pundit: white-list approach.
  after_action :verify_authorized, unless: :skip_pundit?
  #after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(root_path)
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/ || pundit_exceptions?
  end

  def pundit_exceptions?
    !(params[:action] == "index" && params[:controller] =~ /photos/) || !(params[:action] == "index" && params[:controller] =~ /prices/)
  end

  def profile_completed?
    if user_signed_in? && !current_user.username
      redirect_to complete_profile_users_path if params[:controller] != 'users/sessions'
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :location, :avatar])
  end

  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    store_location_for(:user, request.fullpath)
  end


  def after_sign_in_path_for(resource)
    races_path
  end

  def after_sign_out_path_for(resource_or_scope)
    races_path
  end


end
