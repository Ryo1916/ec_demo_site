class Product < ApplicationRecord
  mount_uploader :img_name, ImageUploader
  validates :quantity, presence: true
end
