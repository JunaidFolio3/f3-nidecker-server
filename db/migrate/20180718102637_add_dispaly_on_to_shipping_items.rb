class AddDispalyOnToShippingItems < ActiveRecord::Migration[5.2]
  def change
    add_column :spree_shipping_methods, :display_on, :string
    add_column :spree_shipping_methods, :delete_at, :timestamp
    add_column :spree_shipping_methods, :tracking_url, :string
    add_column :spree_shipping_methods, :admin_name, :string
    add_column :spree_shipping_methods, :tax_category_id, :integer
    add_column :spree_shipping_methods, :code, :string
    add_column :spree_shipping_methods, :store_id, :string
  end
end
