class Users::RegistrationsController < Devise::RegistrationsController
  protected

  def sign_up(resource_name, resource);end

  def after_sign_up_path_for(resource)
    new_user_session_path
  end

  def after_update_path_for(resource)
    mypage_path
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end
end
