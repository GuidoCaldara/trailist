class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
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
      redirect_to complete_profile_users_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :location, :avatar])
  end

end
