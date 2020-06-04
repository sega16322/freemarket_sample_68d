FactoryBot.define do
  factory :sales_price, class: SalesPrice do
    price {100}
  end
  
  factory :not_sales_price, class: SalesPrice do
    
  end
end
