class AddDeleteAtToTaxCodes < ActiveRecord::Migration[5.2]
  def change
    add_column :tax_codes, :amount, :float
    add_column :tax_codes, :delete_at, :timestamp
  end
end
