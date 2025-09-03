class DeviseMailerPreview < ActionMailer::Preview
  def reset_password_instructions
    user = User.first || User.new(name: "テストユーザー", email: "test@example.com")
    token = "sample_reset_token_123"
    Devise::Mailer.reset_password_instructions(user, token)
  end
end
