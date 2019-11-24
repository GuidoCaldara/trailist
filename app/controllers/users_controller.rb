class UsersController < ApplicationController
  skip_before_action :profile_completed?, only: [:save_profile, :complete_profile]

  def show
    @user = User.find(params[:id])
    authorize @user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to @user
    end
  end

  def complete_profile
    @user = current_user
  end

  def save_profile
    @user = current_user
    @user.update(user_params)
    @user.save
    respond_to do |format|
      format.html { redirect_to root_path}
      format.js
    end
  end

  def user_params
    params.require(:user).permit(:username, :location)
  end
end
