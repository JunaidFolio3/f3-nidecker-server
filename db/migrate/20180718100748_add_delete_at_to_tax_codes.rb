class AddDeleteAtToTaxCodes < ActiveRecord::Migration[5.2]
  def change
    add_column :spree_tax_rates, :amount, :float
    add_column :spree_tax_rates, :delete_at, :timestamp
  end
end
