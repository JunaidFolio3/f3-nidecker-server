class AddAmountToTaxCodes < ActiveRecord::Migration[5.2]
  def change
    add_column :spree_tax_rates, :tax_category_id, :integer
    add_column :spree_tax_rates, :zone_id, :integer
    add_column :spree_tax_rates, :included_in_price, :boolean
    add_column :spree_tax_rates, :show_rate_in_label, :boolean
    add_column :spree_tax_rates, :store_id, :integer
  end
end
