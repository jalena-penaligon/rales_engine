require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)
    expect(merchants["data"].first.count).to eq(3)
  end

  it "can show merchants by id" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    id = merchant_1.id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)
    expect(response).to be_successful

    expect(merchant["data"]["id"].to_i).to eq(id)
  end

  it "can find a merchant by id" do
    id = create(:merchant).id

    get "/api/v1/merchants/find?id=#{id}"

    merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchant["data"]["id"].to_i).to eq(id)
  end

  it "can find a merchant by name" do
    name = create(:merchant).name

    get "/api/v1/merchants/find?name=#{name}"

    merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchant["data"]["attributes"]["name"]).to eq(name)
  end

  it "can find a merchant by created_at timestamp" do
    merchant = create(:merchant, created_at: "2012-03-27 14:53:59")
    name = merchant.name
    created_at = merchant.created_at

    get "/api/v1/merchants/find?created_at=#{created_at}"

    merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchant["data"]["attributes"]["name"]).to eq(name)
  end

  it "can find a merchant by updated_at timestamp" do
    merchant = create(:merchant, created_at: "2012-03-27 14:53:59", updated_at: "2012-03-27 14:53:59 UTC")
    name = merchant.name
    updated_at = merchant.updated_at

    get "/api/v1/merchants/find?updated_at=#{updated_at}"

    merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchant["data"]["attributes"]["name"]).to eq(name)
  end

  it "can find all merchants by id" do
    id = create(:merchant).id

    get "/api/v1/merchants/find_all?id=#{id}"

    merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchant["data"].first["attributes"]["id"]).to eq(id)
  end

  it "can find all merchants by name" do
    name = create(:merchant).name

    get "/api/v1/merchants/find_all?name=#{name}"

    merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchant["data"].first["attributes"]["name"]).to eq(name)
  end

  it "can find all merchants by created_at timestamp" do
    merchant = create(:merchant, created_at: "2012-03-27 14:53:59")
    name = merchant.name
    created_at = merchant.created_at

    get "/api/v1/merchants/find_all?created_at=#{created_at}"

    merchant = JSON.parse(response.body)
    expect(response).to be_successful

    expect(merchant["data"].first["attributes"]["name"]).to eq(name)
  end

  it "can find all merchants by updated_at timestamp" do
    merchant = create(:merchant, created_at: "2012-03-27 14:53:59", updated_at: "2012-03-27 14:53:59 UTC")
    name = merchant.name
    updated_at = merchant.updated_at

    get "/api/v1/merchants/find_all?updated_at=#{updated_at}"

    merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchant["data"].first["attributes"]["name"]).to eq(name)
  end

  it "can select a random merchant" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    merchant_3 = create(:merchant)

    get "/api/v1/merchants/random"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"].count).to eq(1)
    expect(merchant["data"].first["type"]).to eq("merchant")
  end

  describe 'business intelligence' do
    before(:each) do
      @customer = create(:customer)

      @merchant_1 = create(:merchant)
      @item_1 = create(:item, merchant: @merchant_1, unit_price: 1250)
      @invoice_1 = create(:invoice, merchant: @merchant_1, customer: @customer, created_at: "2012-03-27 14:54:09 UTC")
      @transaction_1 = create(:transaction, invoice: @invoice_1, result: 0)
      @invoice_item_1 = create(:invoice_item, item: @item_1, invoice: @invoice_1, quantity: 2, unit_price: 1250)
      @invoice_01 = create(:invoice, merchant: @merchant_1, customer: @customer)
      @transaction_01 = create(:transaction, invoice: @invoice_01, result: 0)
      @invoice_item_01 = create(:invoice_item, item: @item_1, invoice: @invoice_1, quantity: 4, unit_price: 1250)

      @merchant_2 = create(:merchant)
      @item_2 = create(:item, merchant: @merchant_2, unit_price: 400)
      @invoice_2 = create(:invoice, merchant: @merchant_2, customer: @customer, created_at: "2012-03-27 14:54:09 UTC")
      @transaction_2 = create(:transaction, invoice: @invoice_2, result: 0)
      @invoice_item_2 = create(:invoice_item, item: @item_2, invoice: @invoice_2, quantity: 2, unit_price: 400)
      @invoice_02 = create(:invoice, merchant: @merchant_2, customer: @customer)
      @transaction_02 = create(:transaction, invoice: @invoice_02, result: 0)
      @invoice_item_02 = create(:invoice_item, item: @item_2, invoice: @invoice_2, quantity: 6, unit_price: 400)

      @merchant_3 = create(:merchant)
      @item_3 = create(:item, merchant: @merchant_3, unit_price: 6000)
      @invoice_3 = create(:invoice, merchant: @merchant_3, customer: @customer, created_at: "2012-03-27 14:54:09 UTC")
      @transaction_3 = create(:transaction, invoice: @invoice_3, result: 0)
      @invoice_item_3 = create(:invoice_item, item: @item_3, invoice: @invoice_3, quantity: 4, unit_price: 6000)
      @invoice_03 = create(:invoice, merchant: @merchant_3, customer: @customer)
      @transaction_03 = create(:transaction, invoice: @invoice_03, result: 0)
      @invoice_item_03 = create(:invoice_item, item: @item_3, invoice: @invoice_3, quantity: 3, unit_price: 6000)
    end

    it "can show top x merchants by revenue" do

      get "/api/v1/merchants/most_revenue?quantity=3"

      merchants = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchants["data"].count).to eq(3)

      expect(merchants["data"][0]["attributes"]["name"]).to eq(@merchant_3.name)
      expect(merchants["data"][1]["attributes"]["name"]).to eq(@merchant_1.name)
      expect(merchants["data"][2]["attributes"]["name"]).to eq(@merchant_2.name)
    end

    it "can show top x merchants by items sold" do

      get "/api/v1/merchants/most_items?quantity=3"

      merchants = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchants["data"].count).to eq(3)

      expect(merchants["data"][0]["attributes"]["name"]).to eq(@merchant_2.name)
      expect(merchants["data"][1]["attributes"]["name"]).to eq(@merchant_3.name)
      expect(merchants["data"][2]["attributes"]["name"]).to eq(@merchant_1.name)
    end

    it "can show revenue across all merchants on a given date" do

      get "/api/v1/merchants/revenue?date=2012-03-27"

      merchants = JSON.parse(response.body)

      expect(response).to be_successful
      expect(merchants["data"]["attributes"]).to eq("total_revenue" => "527.0")
    end

    it "can show all of a single merchants items" do
      merchant_1 = create(:merchant)
      item_1 = create(:item, merchant: merchant_1)
      item_2 = create(:item, merchant: merchant_1)
      item_2 = create(:item, merchant: merchant_1)
      id = merchant_1.id

      get "/api/v1/merchants/#{id}/items"

      items = JSON.parse(response.body)["data"]

      expect(response).to be_successful

      expect(items[0].count).to eq(3)
      expect(items[0]["type"]).to eq("item")
    end

    it "can show all of a single merchants invoices" do
      customer_1 = create(:customer)
      #expected in output
      merchant_1 = create(:merchant)
      invoice_1 = create(:invoice, merchant: merchant_1, customer: customer_1)
      invoice_2 = create(:invoice, merchant: merchant_1, customer: customer_1)
      invoice_3 = create(:invoice, merchant: merchant_1, customer: customer_1)

      #expected to not be in output
      merchant_2 = create(:merchant)
      invoice_4 = create(:invoice, merchant: merchant_2, customer: customer_1)

      id = merchant_1.id
      get "/api/v1/merchants/#{id}/invoices"

      items = JSON.parse(response.body)["data"]

      expect(response).to be_successful

      expect(items[0].count).to eq(3)
      expect(items[0]["type"]).to eq("invoice")
    end

    it "can show revenue for a merchant" do
      customer_1 = create(:customer)
      merchant_1 = create(:merchant)
      item_1 = create(:item, merchant: merchant_1)

      invoice_1 = create(:invoice, merchant: merchant_1, customer: customer_1)
      transaction_1 = create(:transaction, result: 0, invoice: invoice_1)
      invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice_1, quantity: 4, unit_price: 500)

      invoice_2 = create(:invoice, merchant: merchant_1, customer: customer_1)
      transaction_2 = create(:transaction, result: 0, invoice: invoice_2)
      invoice_item_2 = create(:invoice_item, item: item_1, invoice: invoice_2, quantity: 2, unit_price: 1000)

      invoice_3 = create(:invoice, merchant: merchant_1, customer: customer_1)
      transaction_3 = create(:transaction, result: 0, invoice: invoice_3)
      invoice_item_3 = create(:invoice_item, item: item_1, invoice: invoice_3, quantity: 5, unit_price: 2000)

      id = merchant_1.id
      get "/api/v1/merchants/#{id}/revenue"

      revenue = JSON.parse(response.body)["data"]

      expect(response).to be_successful

      expect(revenue["type"]).to eq("revenue")
      expect(revenue["attributes"]).to eq("revenue" => "140.0")
    end

    it "can show revenue for a merchant on a given date" do
      customer_1 = create(:customer)
      merchant_1 = create(:merchant)
      item_1 = create(:item, merchant: merchant_1)

      invoice_1 = create(:invoice, merchant: merchant_1, customer: customer_1, created_at: "2012-03-12 05:54:09 UTC")
      transaction_1 = create(:transaction, result: 0, invoice: invoice_1)
      invoice_item_1 = create(:invoice_item, item: item_1, invoice: invoice_1, quantity: 4, unit_price: 500)

      invoice_2 = create(:invoice, merchant: merchant_1, customer: customer_1, created_at: "2012-03-12 05:54:09 UTC")
      transaction_2 = create(:transaction, result: 0, invoice: invoice_2)
      invoice_item_2 = create(:invoice_item, item: item_1, invoice: invoice_2, quantity: 2, unit_price: 1000)

      invoice_3 = create(:invoice, merchant: merchant_1, customer: customer_1)
      transaction_3 = create(:transaction, result: 0, invoice: invoice_3)
      invoice_item_3 = create(:invoice_item, item: item_1, invoice: invoice_3, quantity: 5, unit_price: 2000)

      id = merchant_1.id
      get "/api/v1/merchants/#{id}/revenue?date=2012-03-12"

      revenue = JSON.parse(response.body)["data"]

      expect(response).to be_successful

      expect(revenue["type"]).to eq("revenue")
      expect(revenue["attributes"]).to eq("revenue" => "40.0")
    end
  end
end
