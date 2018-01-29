class User < ApplicationRecord
  mount_uploader :image, ImageUploader
  has_secure_password
    validates :username, presence: true
    validates :password, presence: true, length: {minimum: 4}
    validates :email, presence: true, uniqueness: true
    validates :date_of_birth, presence: true
    # validates :image, presence: true
end
