require 'rails_helper'

describe "Invoices API" do
  it "sends a list of invoices" do
    customer = create(:customer)
    merchant = create(:merchant)
    create_list(:invoice, 3, customer: customer, merchant: merchant)

    get '/api/v1/invoices'

    expect(response).to be_successful

    invoices = JSON.parse(response.body)["data"]
    expect(invoices.count).to eq(3)
  end

  it "can show invoices by id" do
    customer = create(:customer)
    merchant = create(:merchant)
    id = create(:invoice, customer: customer, merchant: merchant).id

    get "/api/v1/invoices/#{id}"

    invoice = JSON.parse(response.body)["data"]
    expect(response).to be_successful
    expect(invoice["id"].to_i).to eq(id)
  end

  it "can find invoices by id" do
    customer = create(:customer)
    merchant = create(:merchant)
    id = create(:invoice, customer: customer, merchant: merchant).id

    get "/api/v1/invoices/find?id=#{id}"

    invoice = JSON.parse(response.body)["data"]
    expect(response).to be_successful
    expect(invoice["id"].to_i).to eq(id)
  end

  it "can find invoices by customer id" do
    customer = create(:customer)
    merchant = create(:merchant)
    id = create(:invoice, customer: customer, merchant: merchant).id
    customer_id = customer.id

    get "/api/v1/invoices/find?customer_id=#{customer_id}"

    invoice = JSON.parse(response.body)["data"]
    expect(response).to be_successful
    expect(invoice["id"].to_i).to eq(id)
  end

  it "can find invoices by merchant id" do
    customer = create(:customer)
    merchant = create(:merchant)
    id = create(:invoice, customer: customer, merchant: merchant).id
    merchant_id = merchant.id

    get "/api/v1/invoices/find?merchant_id=#{merchant_id}"

    invoice = JSON.parse(response.body)["data"]
    expect(response).to be_successful
    expect(invoice["id"].to_i).to eq(id)
  end

  it "can find invoices by status" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    status = invoice.status
    id = invoice.id

    get "/api/v1/invoices/find?status=#{status}"

    invoice = JSON.parse(response.body)["data"]
    expect(response).to be_successful
    expect(invoice["id"].to_i).to eq(id)
  end

  it "can find an invoice by created_at timestamp" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant, created_at: "2012-03-27 14:53:59 UTC")
    id = invoice.id
    created_at = invoice.created_at

    get "/api/v1/invoices/find?created_at=#{created_at}"

    invoice = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice["data"]["id"].to_i).to eq(id)
  end

  it "can find an invoice by updated_at timestamp" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant, updated_at: "2012-03-27 14:53:59 UTC")
    id = invoice.id
    updated_at = invoice.updated_at

    get "/api/v1/invoices/find?updated_at=#{updated_at}"

    invoice = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice["data"]["id"].to_i).to eq(id)
  end

  it "can find all invoices by id" do
    customer = create(:customer)
    merchant = create(:merchant)
    id = create(:invoice, customer: customer, merchant: merchant).id

    get "/api/v1/invoices/find_all?id=#{id}"

    invoice = JSON.parse(response.body)["data"][0]

    expect(response).to be_successful
    expect(invoice["id"].to_i).to eq(id)
  end

  it "can find all invoices by customer id" do
    customer = create(:customer)
    merchant = create(:merchant)
    id = create(:invoice, customer: customer, merchant: merchant).id
    customer_id = customer.id

    get "/api/v1/invoices/find_all?customer_id=#{customer_id}"

    invoice = JSON.parse(response.body)["data"][0]

    expect(response).to be_successful
    expect(invoice["id"].to_i).to eq(id)
  end

  it "can find all invoices by merchant id" do
    customer = create(:customer)
    merchant = create(:merchant)
    id = create(:invoice, customer: customer, merchant: merchant).id
    merchant_id = merchant.id

    get "/api/v1/invoices/find_all?merchant_id=#{merchant_id}"

    invoice = JSON.parse(response.body)["data"][0]
    expect(response).to be_successful
    expect(invoice["id"].to_i).to eq(id)
  end

  it "can find all invoices by status" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    status = invoice.status
    id = invoice.id

    get "/api/v1/invoices/find_all?status=#{status}"

    invoice = JSON.parse(response.body)["data"][0]
    expect(response).to be_successful
    expect(invoice["id"].to_i).to eq(id)
  end

  it "can find all invoices by created_at timestamp" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant, created_at: "2012-03-27 14:53:59 UTC")
    id = invoice.id
    created_at = invoice.created_at

    get "/api/v1/invoices/find_all?created_at=#{created_at}"

    invoice = JSON.parse(response.body)["data"][0]

    expect(response).to be_successful
    expect(invoice["id"].to_i).to eq(id)
  end

  it "can find all invoices by updated_at timestamp" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant, updated_at: "2012-03-27 14:53:59 UTC")
    id = invoice.id
    updated_at = invoice.updated_at

    get "/api/v1/invoices/find_all?updated_at=#{updated_at}"

    invoice = JSON.parse(response.body)["data"][0]
    expect(response).to be_successful
    expect(invoice["id"].to_i).to eq(id)
  end

  it 'can show the associated transactions for an invoice' do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    transaction_1 = create(:transaction, invoice: invoice)
    transaction_2 = create(:transaction, invoice: invoice)
    transaction_3 = create(:transaction, invoice: invoice)
    id = invoice.id

    get "/api/v1/invoices/#{id}/transactions"

    transactions = JSON.parse(response.body)["data"]
    expect(response).to be_successful
    expect(transactions.count).to eq(3)
    expect(transactions[0]["attributes"]["invoice_id"].to_i).to eq(id)
  end

  it 'can show the associated invoice items for an invoice' do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    invoice_item_1 = create(:invoice_item, item: item, invoice: invoice)
    invoice_item_2 = create(:invoice_item, item: item, invoice: invoice)
    id = invoice.id

    get "/api/v1/invoices/#{id}/invoice_items"

    invoice_items = JSON.parse(response.body)["data"]
    expect(response).to be_successful
    expect(invoice_items.count).to eq(2)
    expect(invoice_items[0]["attributes"]["invoice_id"].to_i).to eq(id)
  end

  it 'can show the associated items for an invoice' do
    merchant = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant: merchant)
    item_2 = create(:item, merchant: merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice)
    invoice_item_2 = create(:invoice_item, item: item_2, invoice: invoice)
    id = invoice.id

    get "/api/v1/invoices/#{id}/items"

    item = JSON.parse(response.body)["data"]
    expect(response).to be_successful
    expect(item.count).to eq(2)
    expect(item[0]["type"]).to eq("item")
    expect(item[0]["attributes"]["id"].to_i).to eq(item_1.id)
    expect(item[1]["attributes"]["id"].to_i).to eq(item_2.id)
  end

  it 'can show the associated customer for an invoice' do
    merchant = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant: merchant)
    item_2 = create(:item, merchant: merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice)
    invoice_item_2 = create(:invoice_item, item: item_2, invoice: invoice)
    id = invoice.id
    customer_id = customer.id

    get "/api/v1/invoices/#{id}/customer"

    customer = JSON.parse(response.body)["data"]
    expect(response).to be_successful
    expect(customer["type"]).to eq("customer")
    expect(customer["attributes"]["id"].to_i).to eq(customer_id)
  end

  it 'can show the associated merchant for an invoice' do
    merchant = create(:merchant)
    customer = create(:customer)
    item_1 = create(:item, merchant: merchant)
    item_2 = create(:item, merchant: merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice)
    invoice_item_2 = create(:invoice_item, item: item_2, invoice: invoice)
    id = invoice.id
    merchant_id = merchant.id

    get "/api/v1/invoices/#{id}/merchant"

    merchant = JSON.parse(response.body)["data"]
    expect(response).to be_successful
    expect(merchant["type"]).to eq("merchant")
    expect(merchant["attributes"]["id"].to_i).to eq(merchant_id)
  end
end
