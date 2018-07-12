class CreateShippingItems < ActiveRecord::Migration[5.2]
  def change
    create_table :shipping_items do |t|
      t.string :name
      t.string :rate
      
      t.timestamps
    end
  end
end
