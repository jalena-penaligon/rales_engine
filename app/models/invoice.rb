class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :invoice_items
  has_many :transactions

  def self.revenue(date)
    select("sum(invoice_items.quantity * invoice_items.unit_price) as total_revenue")
    .joins(:invoice_items, :transactions)
    .where(transactions: {result: 0})
    .where(:created_at => date.beginning_of_day..date.end_of_day)
  end

  def self.revenue_for(merchant)
    select("sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
    .joins(:invoice_items, :transactions)
    .where(transactions: {result: 0})
    .where(merchant_id: merchant)
  end

  def self.revenue_by_date_for(merchant, date)
    select("sum(invoice_items.quantity * invoice_items.unit_price) as revenue")
    .joins(:invoice_items, :transactions)
    .where(transactions: {result: 0})
    .where(merchant_id: merchant)
    .where(:created_at => date.beginning_of_day..date.end_of_day)
  end

end
