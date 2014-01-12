FactoryGirl.define do
  factory :article do
    name "Super Boots"
    description "Big shiny boots"
    price 127.43
    total_in_shelf 1
    total_in_vault 2
    store_id 1
  end
end