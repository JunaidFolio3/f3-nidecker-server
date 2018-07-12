class ShippingItem < ApplicationRecord
  validates :name, presence: true
  validates :rate, presence: true
end
