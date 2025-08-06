class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable,
         omniauth_providers: [ :google_oauth2 ]

  validates :name, presence: true, length: { maximum: 50 }

  enum :style_category, {
    straight: 0,
    wave: 1,
    natural: 2
  }

  enum :height_range, {
    under_150: 0,
    range_150_155: 1,
    range_155_160: 2,
    range_160_165: 3,
    range_165_170: 4,
    range_170_175: 5,
    range_175_180: 6,
    over_180: 7
  }

  def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_create do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.provider = auth.provider
      user.uid = auth.uid
      user.password = Devise.friendly_token[0, 20]
    end
  end
end
