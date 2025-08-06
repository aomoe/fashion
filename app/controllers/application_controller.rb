class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :authenticate_user!
  allow_browser versions: :modern
  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name ] )
  end

  def after_sign_up_path_for(resource)
    new_user_session_path
  end
end
