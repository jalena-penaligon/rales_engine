class Transaction < ApplicationRecord
  belongs_to :invoice
  enum result:['success', 'failed']

  def self.by_customer(customer_id)
    joins(:invoice)
    .select('transactions.*')
    .where("invoices.customer_id = #{customer_id}")
  end
end
