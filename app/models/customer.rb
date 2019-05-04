class Customer < ApplicationRecord
  has_many :invoices

  def self.favorite_customer_of(merchant)
    joins(invoices: :transactions)
    .select('customers.*, count(transactions.id) as total_transactions')
    .where("invoices.merchant_id = ?", merchant.id)
    .where(transactions: { result: 0 })
    .group(:id)
    .order('total_transactions DESC')
    .limit(1)
  end

end
