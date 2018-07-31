class SpreeShippingMethod < ApplicationRecord
  self.table_name = "shipping_items"
  # self.table_name = "spree_shipping_methods"
  validates :name, presence: true
  # validates :rate, presence: true
end
