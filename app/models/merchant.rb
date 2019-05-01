class Merchant < ApplicationRecord
  has_many :items

  def self.most_revenue(limit)
    joins(items: :invoice_items)
    .select("merchants.*, sum(invoice_items.unit_price * invoice_items.quantity) as revenue")
    .group(:id)
    .order("revenue DESC")
    .limit(limit)
  end

  def self.most_items(limit)
    joins(items: :invoice_items)
    .select("merchants.*, sum(invoice_items.quantity) as items_sold")
    .group(:id)
    .order("items_sold DESC")
    .limit(limit)
  end

  def self.revenue(date)
    joins(items: :invoice_items)
    .where("invoice_items.created_at = '#{date}'")
    .sum('invoice_items.unit_price * invoice_items.quantity')
  end
end
