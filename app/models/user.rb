class User < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_secure_password(validations: false)
    validates :username, presence: true
    validates :password, presence: true, length: {minimum: 4}, allow_nil: true
    validates :email, presence: false, uniqueness: true
    # validates :date_of_birth, presence: true
    # validates :image, presence: true

  def self.sign_in_from_omniauth(auth)
    find_by(provider: auth['provider'], uid: auth['uid']) || create_user_from_omniauth(auth)
  end

  def self.create_user_from_omniauth(auth)
    create(
      username: auth['info']['name'],
      email: auth['info']['email'],
      image: auth['info']['image'],
      provider: auth['provider'],
      uid: auth['uid']
    )
  end
end
