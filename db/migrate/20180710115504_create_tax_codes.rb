class CreateTaxCodes < ActiveRecord::Migration[5.2]
  def change
    create_table :tax_codes do |t|
      t.string :name
      t.string :rate
      
      t.timestamps
    end
  end
end
