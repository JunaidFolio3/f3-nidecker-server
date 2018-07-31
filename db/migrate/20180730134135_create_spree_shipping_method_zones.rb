class CreateSpreeShippingMethodZones < ActiveRecord::Migration[5.2]
  def change
    create_table :spree_shipping_method_zones do |t|
      t.integer :shipping_method_id
      t.integer :zone_id

      t.timestamps
    end
  end
end
