require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    merchant = create(:merchant)
    create_list(:item, 3, merchant: merchant)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)["data"]
    expect(items.count).to eq(3)
  end

  it "can show items by id" do
    merchant = create(:merchant)
    id = create(:item, merchant: merchant).id

    get "/api/v1/items/#{id}"

    item = JSON.parse(response.body)["data"]
    expect(response).to be_successful
    expect(item["id"].to_i).to eq(id)
  end

  it "can find an item by id" do
    merchant = create(:merchant)
    id = create(:item, merchant: merchant).id

    get "/api/v1/items/find?id=#{id}"

    item = JSON.parse(response.body)["data"]
    expect(response).to be_successful
    expect(item["id"].to_i).to eq(id)
  end

  it "can find an item by name" do
    merchant = create(:merchant)
    name = create(:item, merchant: merchant).name

    get "/api/v1/items/find?name=#{name}"

    item = JSON.parse(response.body)["data"]
    expect(response).to be_successful
    expect(item["attributes"]["name"]).to eq(name)
  end

  it "can find an item by description" do
    merchant = create(:merchant)
    description = create(:item, merchant: merchant).description

    get "/api/v1/items/find?description=#{description}"

    item = JSON.parse(response.body)["data"]
    expect(response).to be_successful
    expect(item["attributes"]["description"]).to eq(description)
  end

  it "can find an item by merchant id" do
    merchant = create(:merchant)
    description = create(:item, merchant: merchant).description
    merchant_id = merchant.id

    get "/api/v1/items/find?merchant_id=#{merchant_id}"

    item = JSON.parse(response.body)["data"]
    expect(response).to be_successful
    expect(item["attributes"]["merchant_id"]).to eq(merchant_id)
  end

  it "can find an item by unit price" do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant, unit_price: 355)
    unit_price = 3.55

    get "/api/v1/items/find?unit_price=#{unit_price}"

    item = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(item["attributes"]["unit_price"].to_f).to eq(unit_price)
  end

  it "can find an item by created_at timestamp" do
    merchant = create(:merchant)
    item = create(:item, created_at: "2012-03-27 14:53:59", merchant: merchant)
    name = item.name
    created_at = item.created_at

    get "/api/v1/items/find?created_at=#{created_at}"

    item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(item["data"]["attributes"]["name"]).to eq(name)
  end

  it "can find an item by updated_at timestamp" do
    merchant = create(:merchant)
    item = create(:item, updated_at: "2012-03-27 14:53:59 UTC", merchant: merchant)
    name = item.name
    updated_at = item.updated_at

    get "/api/v1/items/find?updated_at=#{updated_at}"

    item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(item["data"]["attributes"]["name"]).to eq(name)
  end

  it "can find all items by id" do
    merchant = create(:merchant)
    id = create(:item, merchant: merchant).id

    get "/api/v1/items/find_all?id=#{id}"

    item = JSON.parse(response.body)["data"]
    expect(response).to be_successful
    expect(item[0]["id"].to_i).to eq(id)
  end

  it "can find all items by name" do
    merchant = create(:merchant)
    name = create(:item, merchant: merchant).name

    get "/api/v1/items/find_all?name=#{name}"

    item = JSON.parse(response.body)["data"]
    expect(response).to be_successful
    expect(item[0]["attributes"]["name"]).to eq(name)
  end

  it "can find all items by description" do
    merchant = create(:merchant)
    description = create(:item, merchant: merchant).description

    get "/api/v1/items/find_all?description=#{description}"

    item = JSON.parse(response.body)["data"]
    expect(response).to be_successful
    expect(item[0]["attributes"]["description"]).to eq(description)
  end

  it "can find all items by merchant id" do
    merchant = create(:merchant)
    description = create(:item, merchant: merchant).description
    merchant_id = merchant.id

    get "/api/v1/items/find_all?merchant_id=#{merchant_id}"

    item = JSON.parse(response.body)["data"][0]
    expect(response).to be_successful
    expect(item["attributes"]["merchant_id"]).to eq(merchant_id)
  end

  it "can find all items by unit price" do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant, unit_price: 355)
    unit_price = 3.55

    get "/api/v1/items/find_all?unit_price=#{unit_price}"

    item = JSON.parse(response.body)["data"][0]

    expect(response).to be_successful
    expect(item["attributes"]["unit_price"].to_f).to eq(unit_price)
  end

  it "can find all items by created_at timestamp" do
    merchant = create(:merchant)
    item = create(:item, created_at: "2012-03-27 14:53:59", merchant: merchant)
    name = item.name
    created_at = item.created_at

    get "/api/v1/items/find_all?created_at=#{created_at}"

    item = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(item[0]["attributes"]["name"]).to eq(name)
  end

  it "can find all items by updated_at timestamp" do
    merchant = create(:merchant)
    item = create(:item, updated_at: "2012-03-27 14:53:59 UTC", merchant: merchant)
    name = item.name
    updated_at = item.updated_at

    get "/api/v1/items/find_all?updated_at=#{updated_at}"

    item = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(item[0]["attributes"]["name"]).to eq(name)
  end

  it 'can find all invoice items for a given item' do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    id = item.id
    invoice = create(:invoice, merchant: merchant, customer: customer)
    invoice_item_1 = create(:invoice_item, item: item, invoice: invoice)
    invoice_item_2 = create(:invoice_item, item: item, invoice: invoice)
    invoice_item_3 = create(:invoice_item, item: item, invoice: invoice)

    get "/api/v1/items/#{id}/invoice_items"

    invoice_items = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(invoice_items.count).to eq(3)
    expect(invoice_items[0]["type"]).to eq("invoice_items")
  end

  it 'can show the associated merchant' do
    merchant = create(:merchant)
    item = create(:item, merchant: merchant)
    name = merchant.name
    id = item.id

    get "/api/v1/items/#{id}/merchant"

    merchant = JSON.parse(response.body)["data"]

    expect(response).to be_successful

    expect(merchant["type"]).to eq("merchant")
    expect(merchant["attributes"]["name"]).to eq(name)
  end

  it 'returns the top x items ranked by total revenue generated' do
    customer = create(:customer)
    merchant = create(:merchant)
    item_1 = create(:item, merchant: merchant)
    item_2 = create(:item, merchant: merchant)
    item_3 = create(:item, merchant: merchant)

    invoice_1 = create(:invoice, customer: customer, merchant: merchant)
    invoice_item_1 = create(:invoice_item, item: item_1, quantity: 5, unit_price: 100, invoice: invoice_1)
    transaction_1 = create(:transaction, invoice: invoice_1, result: 0)

    invoice_2 = create(:invoice, customer: customer, merchant: merchant)
    invoice_item_2 = create(:invoice_item, item: item_1, quantity: 3, unit_price: 200, invoice: invoice_2)
    transaction_2 = create(:transaction, invoice: invoice_2, result: 0)

    invoice_3 = create(:invoice, customer: customer, merchant: merchant)
    invoice_item_3 = create(:invoice_item, item: item_2, quantity: 4, unit_price: 300, invoice: invoice_3)
    transaction_3 = create(:transaction, invoice: invoice_2, result: 0)

    invoice_4 = create(:invoice, customer: customer, merchant: merchant)
    invoice_item_4 = create(:invoice_item, item: item_3, quantity: 6, unit_price: 400, invoice: invoice_4)
    transaction_4 = create(:transaction, invoice: invoice_3, result: 0)

    get "/api/v1/items/most_revenue?quantity=2"

    items = JSON.parse(response.body)["data"]

    expect(response).to be_successful

    expect(items[0]["type"]).to eq("item")
    expect(items[0]["attributes"]["name"]).to eq(item_3.name)
    expect(items[1]["attributes"]["name"]).to eq(item_1.name)
  end

  it 'returns the top x items ranked by total items sold' do
    customer = create(:customer)
    merchant = create(:merchant)
    item_1 = create(:item, merchant: merchant)
    item_2 = create(:item, merchant: merchant)
    item_3 = create(:item, merchant: merchant)

    invoice_1 = create(:invoice, customer: customer, merchant: merchant)
    invoice_item_1 = create(:invoice_item, item: item_1, quantity: 5, invoice: invoice_1)
    transaction_1 = create(:transaction, invoice: invoice_1, result: 0)

    invoice_2 = create(:invoice, customer: customer, merchant: merchant)
    invoice_item_2 = create(:invoice_item, item: item_1, quantity: 3, invoice: invoice_2)
    transaction_2 = create(:transaction, invoice: invoice_2, result: 0)

    invoice_3 = create(:invoice, customer: customer, merchant: merchant)
    invoice_item_3 = create(:invoice_item, item: item_2, quantity: 4, invoice: invoice_3)
    transaction_3 = create(:transaction, invoice: invoice_2, result: 0)

    invoice_4 = create(:invoice, customer: customer, merchant: merchant)
    invoice_item_4 = create(:invoice_item, item: item_3, quantity: 6, invoice: invoice_4)
    transaction_4 = create(:transaction, invoice: invoice_3, result: 0)

    get "/api/v1/items/most_items?quantity=2"

    items = JSON.parse(response.body)["data"]

    expect(response).to be_successful

    expect(items[0]["type"]).to eq("item")
    expect(items[0]["attributes"]["name"]).to eq(item_1.name)
    expect(items[1]["attributes"]["name"]).to eq(item_3.name)
  end

  it 'returns an items best day for sales using the invoice date' do
    customer = create(:customer)
    merchant = create(:merchant)
    item_1 = create(:item, merchant: merchant)

    invoice_1 = create(:invoice, customer: customer, merchant: merchant, created_at: "2012-03-27 14:53:59 UTC")
    invoice_item_1 = create(:invoice_item, item: item_1, quantity: 5, invoice: invoice_1)
    transaction_1 = create(:transaction, invoice: invoice_1, result: 0)

    invoice_2 = create(:invoice, customer: customer, merchant: merchant, created_at: "2012-03-27 14:53:59 UTC")
    invoice_item_2 = create(:invoice_item, item: item_1, quantity: 3, invoice: invoice_2)
    transaction_2 = create(:transaction, invoice: invoice_2, result: 0)

    invoice_3 = create(:invoice, customer: customer, merchant: merchant)
    invoice_item_3 = create(:invoice_item, item: item_1, quantity: 4, invoice: invoice_3)
    transaction_3 = create(:transaction, invoice: invoice_2, result: 0)

    id = item_1.id
    get "/api/v1/items/#{id}/best_day"

    best_day = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(best_day["type"]).to eq("best_day")
    expect(best_day["attributes"]).to eq("best_day" => "2012-03-27")
  end
end
