class Merchant < ApplicationRecord
  has_many :items
  has_many :invoices

  def self.most_revenue(limit)
    joins(items: :invoice_items)
    .select("merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as revenue")
    .group(:id)
    .order("revenue DESC")
    .limit(limit)
  end

  def self.most_items(limit)
    joins(items: [invoice_items: [invoice: :transactions]])
    .select("merchants.*, sum(invoice_items.quantity) as items_sold")
    .where(transactions: {result: 0})
    .group(:id)
    .order("items_sold DESC")
    .limit(limit)
  end

  def self.favorite_merchant_of(customer)
    joins(invoices: :transactions)
    .select('merchants.*, count(transactions.id) as total_transactions')
    .where("invoices.customer_id = #{customer.id}")
    .where(transactions: { result: 0 })
    .group(:id)
    .order('total_transactions DESC')
    .limit(1)
  end
end
