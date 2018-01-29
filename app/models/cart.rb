class Cart < ApplicationRecord
  validates :quantity, presence: true
end
