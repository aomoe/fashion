class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sing_up_params, only: [ :create ]

  protected

  def configure_sing_up_params
    devise_parameter_sanitizer.permit(:sing_up, keys: [ :name ])
  end

  def after_sing_up_path_for(resource)
    new_user_session_path
  end
end
