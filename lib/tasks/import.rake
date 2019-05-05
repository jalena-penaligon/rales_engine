require 'csv'

namespace :import do
  desc "TODO"
  task sales_engine: :environment do
    Rake::Task["db:drop"].execute
    Rake::Task["db:create"].execute
    Rake::Task["db:migrate"].execute

    CSV.foreach('db/sales_engine/customers.csv', headers: true) do |row|
      Customer.create(row.to_h)
    end

    CSV.foreach('db/sales_engine/merchants.csv', headers: true) do |row|
      Merchant.create(row.to_h)
    end

    CSV.foreach('db/sales_engine/items.csv', headers: true) do |row|
      Item.create(row.to_h)
    end

    CSV.foreach('db/sales_engine/invoices.csv', headers: true) do |row|
      Invoice.create(row.to_h)
    end

    CSV.foreach('db/sales_engine/invoice_items.csv', headers: true) do |row|
      InvoiceItem.create(row.to_h)
    end

    CSV.foreach('db/sales_engine/transactions.csv', headers: true) do |row|
      Transaction.create(row.to_h)
    end
  end

end
