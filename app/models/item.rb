class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items

  def self.most_revenue(limit)
    joins(invoice_items: [invoice: :transactions])
    .select('items.*, sum(invoice_items.quantity * invoice_items.unit_price) as revenue')
    .where(transactions: { result: 0 })
    .group(:id)
    .order('revenue DESC')
    .limit(limit)
  end

  def self.most_items(limit)
    joins(invoice_items: [invoice: :transactions])
    .select('items.*, sum(invoice_items.quantity) as items_sold')
    .where(transactions: { result: 0 })
    .group(:id)
    .order('items_sold DESC')
    .limit(limit)
  end

  def self.best_day(item_id)
    joins(invoice_items: [invoice: :transactions])
    .select('invoices.created_at AS best_day, sum(invoice_items.quantity * invoice_items.unit_price) AS sales')
    .where(transactions: { result: 0 })
    .where(id: item_id)
    .group('invoices.created_at')
    .order('sales DESC, invoices.created_at DESC')
    .limit(1)
  end
end
