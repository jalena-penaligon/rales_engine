FactoryBot.define do
  factory :item do
    name { "Item" }
    description { "This is an item." }
    unit_price { 1 }
    merchant { nil }
  end
end
