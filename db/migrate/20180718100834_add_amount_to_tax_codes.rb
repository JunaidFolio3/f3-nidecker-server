class AddAmountToTaxCodes < ActiveRecord::Migration[5.2]
  def change
    add_column :tax_codes, :tax_category_id, :integer
    add_column :tax_codes, :zone_id, :integer
    add_column :tax_codes, :included_in_price, :boolean
    add_column :tax_codes, :show_rate_in_label, :boolean
    add_column :tax_codes, :store_id, :integer
  end
end
