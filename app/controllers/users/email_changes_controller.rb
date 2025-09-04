class Users::EmailChangesController < ApplicationController
  before_action :authenticate_user!, except: [:confirm]

  def new;end

  def create
    new_email = email_change_params[:email].to_s.strip

    if new_email.casecmp?(current_user.email.to_s)
      current_user.errors.add(:email, '現在と同じメールアドレスは指定できません')
      return render :new, status: :unprocessable_entity
    end

    if current_user.update(email_change_params)
      redirect_to edit_user_registration_path, notice: '確認メールを送信しました。新しいメールアドレスをご確認ください。'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def confirm
    user = User.confirm_by_token(params[:confirmation_token])

    if user.errors.empty?
      redirect_to edit_user_registration_path,
                  notion: 'メールアドレスの変更が完了しました。'
    else
      redirect_to edit_user_registration_path,
                  alert: '確認に失敗しました。再度お試しください。'
    end
  end

  private

  def email_change_params
    params.require(:user).permit(:email)
  end
end