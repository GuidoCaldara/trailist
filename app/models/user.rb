class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  devise :omniauthable, omniauth_providers: [:facebook]
  mount_uploader :avatar, PhotoUploader
  after_create :send_welcome_email
  has_many :reviews, dependent: :destroy
  #validates :username, presence: true, on: :update
  has_one :organization, dependent: :destroy
  geocoded_by :location
  after_validation :geocode, if: :location_changed?

    def self.find_for_facebook_oauth(auth)
    user_params = auth.slice("provider", "uid")
    user_params.merge! auth.info.slice("email", "first_name", "last_name")
    user_params[:facebook_picture_url] = auth.info.image
    user_params[:token] = auth.credentials.token
    user_params[:token_expiry] = Time.at(auth.credentials.expires_at)
    user_params = user_params.to_h

    user = User.find_by(provider: auth.provider, uid: auth.uid)
    user ||= User.find_by(email: auth.info.email) # User did a regular sign up in the past.
    if user
      user.update(user_params)
    else
      user = User.new(user_params)
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.save
    end

    return user
  end

  def profile_picture
    return self.facebook_picture_url if self.facebook_picture_url
    return self.avatar.url if !self.avatar.blank?
    return "runner-avatar.png"
  end

  def send_welcome_email
    #mail = UserMailer.with(user: self).welcome_email
    #mail.deliver_now
  end


end
