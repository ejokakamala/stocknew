class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  protected

  def after_sign_in_path_for(user)
    authenticated_root_path unless current_user and current_user.id == params[:id]
  end

end

