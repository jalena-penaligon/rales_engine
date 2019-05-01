FactoryBot.define do
  factory :merchant do
    sequence(:name) { |n| "Merchant Name #{n}" }
  end
end
