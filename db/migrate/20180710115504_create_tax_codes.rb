class CreateTaxCodes < ActiveRecord::Migration[5.2]
  def change
    create_table :spree_tax_rates do |t|
      t.string :name
      t.string :amount
      
      t.timestamps
    end
  end
end
