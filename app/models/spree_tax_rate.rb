class SpreeTaxRate < ApplicationRecord
  self.table_name = "tax_codes"
  # self.table_name = "spree_tax_rates"
  # validates :name
  validates :name, presence: true
  validates :amount, presence: true
  # validates :amount
  # validates :created_at, null: false
  # validates :updated_at, null: false
  # validates :delete_at
  # validates :tax_category_id
  # validates :included_in_price
  # validates :show_rate_in_label
  # validates :store_id
end
