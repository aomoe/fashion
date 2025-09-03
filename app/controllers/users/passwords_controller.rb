class Users::PasswordsController < Devise::PasswordsController
  def create
    email = params.dig(resource_name, :email).to_s.strip
    if email.blank?
      self.resource = resource_class.new
      resource.errors.add(:email, :blank)
      respond_with(resource) { render :new, status: :unprocessable_entity }
      return
    end
    super
  end
  protected

  def after_resetting_password_path_for(resource)
    posts_path
  end
end
