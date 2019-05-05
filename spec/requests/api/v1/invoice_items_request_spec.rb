require 'rails_helper'

describe "Invoice Items API" do
  it "sends a list of invoice items" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    create_list(:invoice_item, 3, item: item, invoice: invoice)

    get '/api/v1/invoice_items'

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)["data"]
    expect(invoice_items.count).to eq(3)
  end

  it "can show invoice items by id" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    id = create(:invoice_item, item: item, invoice: invoice).id

    get "/api/v1/invoice_items/#{id}"

    invoice_item = JSON.parse(response.body)["data"]
    expect(response).to be_successful
    expect(invoice_item["id"].to_i).to eq(id)
  end

  it "can find an invoice item by id" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    id = create(:invoice_item, item: item, invoice: invoice).id

    get "/api/v1/invoice_items/find?id=#{id}"

    invoice_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice_item["data"]["id"].to_i).to eq(id)
  end

  it "can find an invoice item by invoice id" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    id = create(:invoice_item, item: item, invoice: invoice).id
    invoice_id = invoice.id

    get "/api/v1/invoice_items/find?invoice_id=#{invoice_id}"

    invoice_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice_item["data"]["id"].to_i).to eq(id)
  end

  it "can find an invoice item by quantity" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    quantity = create(:invoice_item, item: item, invoice: invoice).quantity

    get "/api/v1/invoice_items/find?quantity=#{quantity}"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item["data"]["attributes"]["quantity"].to_i).to eq(quantity)
  end

  it "can find an invoice item by unit price" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    unit_price = 3.55
    invoice = create(:invoice, customer: customer, merchant: merchant)
    invoice_item = create(:invoice_item, item: item, invoice: invoice, unit_price: 355).quantity

    get "/api/v1/invoice_items/find?unit_price=#{unit_price}"

    invoice_item = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoice_item["attributes"]["unit_price"].to_f).to eq(unit_price)
  end

  it "can find an invoice item by created_at timestamp" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    invoice_item = create(:invoice_item, item: item, invoice: invoice, created_at: "2012-03-27 14:53:59 UTC")
    id = invoice_item.id
    created_at = invoice_item.created_at

    get "/api/v1/invoice_items/find?created_at=#{created_at}"

    invoice_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice_item["data"]["id"].to_i).to eq(id)
  end

  it "can find an invoice item by updated_at timestamp" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    invoice_item = create(:invoice_item, item: item, invoice: invoice, updated_at: "2012-03-27 14:53:59 UTC")
    id = invoice_item.id
    updated_at = invoice_item.updated_at

    get "/api/v1/invoice_items/find?updated_at=#{updated_at}"

    invoice_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice_item["data"]["id"].to_i).to eq(id)
  end

  it "can find an invoice item by id" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    id = create(:invoice_item, item: item, invoice: invoice).id

    get "/api/v1/invoice_items/find?id=#{id}"

    invoice_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice_item["data"]["id"].to_i).to eq(id)
  end

  it "can find an invoice item by invoice id" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    id = create(:invoice_item, item: item, invoice: invoice).id
    invoice_id = invoice.id

    get "/api/v1/invoice_items/find?invoice_id=#{invoice_id}"

    invoice_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice_item["data"]["id"].to_i).to eq(id)
  end

  it "can find an invoice item by item id" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    id = create(:invoice_item, item: item, invoice: invoice).id
    item_id = item.id

    get "/api/v1/invoice_items/find?item_id=#{item_id}"

    invoice_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice_item["data"]["id"].to_i).to eq(id)
  end

  it "can find an invoice item by quantity" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    quantity = create(:invoice_item, item: item, invoice: invoice).quantity

    get "/api/v1/invoice_items/find?quantity=#{quantity}"

    invoice_item = JSON.parse(response.body)

    expect(response).to be_successful
    expect(invoice_item["data"]["attributes"]["quantity"].to_i).to eq(quantity)
  end

  it "can find an invoice item by unit price" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    unit_price = 3.55
    invoice = create(:invoice, customer: customer, merchant: merchant)
    invoice_item = create(:invoice_item, item: item, invoice: invoice, unit_price: 355).quantity

    get "/api/v1/invoice_items/find?unit_price=#{unit_price}"

    invoice_item = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoice_item["attributes"]["unit_price"].to_f).to eq(unit_price)
  end

  it "can find an invoice item by created_at timestamp" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    invoice_item = create(:invoice_item, item: item, invoice: invoice, created_at: "2012-03-27 14:53:59 UTC")
    id = invoice_item.id
    created_at = invoice_item.created_at

    get "/api/v1/invoice_items/find?created_at=#{created_at}"

    invoice_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice_item["data"]["id"].to_i).to eq(id)
  end

  it "can find an invoice item by updated_at timestamp" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    invoice_item = create(:invoice_item, item: item, invoice: invoice, updated_at: "2012-03-27 14:53:59 UTC")
    id = invoice_item.id
    updated_at = invoice_item.updated_at

    get "/api/v1/invoice_items/find?updated_at=#{updated_at}"

    invoice_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice_item["data"]["id"].to_i).to eq(id)
  end

  it "can find all invoice items by id" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    id = create(:invoice_item, item: item, invoice: invoice).id

    get "/api/v1/invoice_items/find_all?id=#{id}"

    invoice_item = JSON.parse(response.body)["data"][0]
    expect(response).to be_successful
    expect(invoice_item["id"].to_i).to eq(id)
  end

  it "can find all invoice items by invoice id" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    id = create(:invoice_item, item: item, invoice: invoice).id
    invoice_id = invoice.id

    get "/api/v1/invoice_items/find_all?invoice_id=#{invoice_id}"

    invoice_item = JSON.parse(response.body)["data"][0]
    expect(response).to be_successful
    expect(invoice_item["id"].to_i).to eq(id)
  end

  it "can find all invoice items by item id" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    id = create(:invoice_item, item: item, invoice: invoice).id
    item_id = item.id

    get "/api/v1/invoice_items/find_all?item_id=#{item_id}"

    invoice_item = JSON.parse(response.body)["data"][0]
    expect(response).to be_successful
    expect(invoice_item["id"].to_i).to eq(id)
  end

  it "can find all invoice items by quantity" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    quantity = create(:invoice_item, item: item, invoice: invoice).quantity

    get "/api/v1/invoice_items/find_all?quantity=#{quantity}"

    invoice_item = JSON.parse(response.body)["data"][0]

    expect(response).to be_successful
    expect(invoice_item["attributes"]["quantity"].to_i).to eq(quantity)
  end

  it "can find all invoice items by unit price" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    unit_price = 3.55
    invoice = create(:invoice, customer: customer, merchant: merchant)
    invoice_item = create(:invoice_item, item: item, invoice: invoice, unit_price: 355).quantity

    get "/api/v1/invoice_items/find_all?unit_price=#{unit_price}"

    invoice_item = JSON.parse(response.body)["data"][0]

    expect(response).to be_successful
    expect(invoice_item["attributes"]["unit_price"].to_f).to eq(unit_price)
  end

  it "can find all invoice items by created_at timestamp" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    invoice_item = create(:invoice_item, item: item, invoice: invoice, created_at: "2012-03-27 14:53:59 UTC")
    id = invoice_item.id
    created_at = invoice_item.created_at

    get "/api/v1/invoice_items/find_all?created_at=#{created_at}"

    invoice_item = JSON.parse(response.body)["data"][0]
    expect(response).to be_successful
    expect(invoice_item["id"].to_i).to eq(id)
  end

  it "can find all invoice items by updated_at timestamp" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    invoice_item = create(:invoice_item, item: item, invoice: invoice, updated_at: "2012-03-27 14:53:59 UTC")
    id = invoice_item.id
    updated_at = invoice_item.updated_at

    get "/api/v1/invoice_items/find_all?updated_at=#{updated_at}"

    invoice_item = JSON.parse(response.body)["data"][0]
    expect(response).to be_successful
    expect(invoice_item["id"].to_i).to eq(id)
  end

  it "shows the invoice associated with an invoice item" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    invoice_item = create(:invoice_item, item: item, invoice: invoice)
    id = invoice_item.id
    invoice_id = invoice.id

    get "/api/v1/invoice_items/#{id}/invoice"
    invoice = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoice["type"]).to eq("invoice")
    expect(invoice["id"].to_i).to eq(invoice_id)
  end

  it "shows the item associated with an invoice item" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    invoice_item = create(:invoice_item, item: item, invoice: invoice)
    id = invoice_item.id
    item_id = item.id

    get "/api/v1/invoice_items/#{id}/item"
    item = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(item["type"]).to eq("item")
    expect(item["id"].to_i).to eq(item_id)
  end
end
