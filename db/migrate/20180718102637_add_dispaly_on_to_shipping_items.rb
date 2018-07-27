class AddDispalyOnToShippingItems < ActiveRecord::Migration[5.2]
  def change
    add_column :shipping_items, :display_on, :string
    add_column :shipping_items, :delete_at, :timestamp
    add_column :shipping_items, :tracking_url, :string
    add_column :shipping_items, :admin_name, :string
    add_column :shipping_items, :tax_category_id, :integer
    add_column :shipping_items, :code, :string
    add_column :shipping_items, :store_id, :string
  end
end
