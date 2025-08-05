class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [ :create ]

  protected

  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [ :email, :password ])
  end

  def after_sign_in_path_for(resource)
    "#"
  end

  def after_sign_out_path_for(resource)
    posts_index_path
  end
end
