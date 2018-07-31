class SpreeShippingMethodZone < ApplicationRecord
  validate :shipping_method_id 
  validate :zone_id 
end
