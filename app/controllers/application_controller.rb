class ApplicationController < ActionController::Base
    def after_sign_up_path_for(resource)
      byebug
    users_edit_profile_path
  end



end
