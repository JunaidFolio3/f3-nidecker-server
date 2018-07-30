Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace 'api' do
    namespace 'v1' do

      get 'taxcodes' => 'spree_tax_rates#parseDate'
      post 'taxcodes' => 'spree_tax_rates#executeDBOperationForTaxCode'
      post 'shippingitems' => 'shipping_items#executeDBOperationForShippingItem'

      resources :articles
    end
  end
end
