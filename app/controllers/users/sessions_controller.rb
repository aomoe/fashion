class Users::SessionsController < Devise::SessionsController
  before_action :configure_sing_in_params, only: [ :create ]

  protected

  def configure_sing_in_params
    devise_parameter_sanitizer.permit(:sing_in, keys: [ :email, :password ])
  end

  def after_sing_in_path(resource)
    root_path
  end

  def after_sing_out_path(resource)
    posts_index_path
  end
end
