require 'rails_helper'

describe "Transaction API" do
  it "sends a list of transactions" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    create_list(:transaction, 3, invoice: invoice)

    get '/api/v1/transactions'

    expect(response).to be_successful

    transactions = JSON.parse(response.body)["data"]
    expect(transactions.count).to eq(3)
  end

  it "can show transactions by id" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    id = create(:transaction, invoice: invoice).id

    get "/api/v1/transactions/#{id}"

    transaction = JSON.parse(response.body)["data"]
    expect(response).to be_successful
    expect(transaction["id"].to_i).to eq(id)
  end

  it "can find a transaction by id" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    id = create(:transaction, invoice: invoice).id

    get "/api/v1/transactions/find?id=#{id}"

    item = JSON.parse(response.body)["data"]
    expect(response).to be_successful
    expect(item["id"].to_i).to eq(id)
  end

  it "can find a transaction by invoice id" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    id = create(:transaction, invoice: invoice).id
    invoice_id = invoice.id

    get "/api/v1/transactions/find?invoice_id=#{invoice_id}"

    item = JSON.parse(response.body)["data"]
    expect(response).to be_successful
    expect(item["id"].to_i).to eq(id)
  end

  it "can find a transaction by credit card number" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    cc = create(:transaction, invoice: invoice).credit_card_number

    get "/api/v1/transactions/find?credit_card_number=#{cc}"

    item = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(item["attributes"]["credit_card_number"]).to eq(cc)
  end

  it "can find a transaction by result" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    result = create(:transaction, invoice: invoice).result

    get "/api/v1/transactions/find?result=#{result}"

    item = JSON.parse(response.body)["data"]

    expect(response).to be_successful
    expect(item["attributes"]["result"]).to eq(result)
  end

  it "can find a transaction item by created_at timestamp" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    invoice_item = create(:invoice_item, item: item, invoice: invoice)
    transaction = create(:transaction, invoice: invoice, created_at: "2012-03-27 14:53:59 UTC")
    id = transaction.id
    created_at = transaction.created_at

    get "/api/v1/transactions/find?created_at=#{created_at}"

    invoice_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice_item["data"]["id"].to_i).to eq(id)
  end

  it "can find a transaction item by updated_at timestamp" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant: merchant)
    invoice = create(:invoice, customer: customer, merchant: merchant)
    invoice_item = create(:invoice_item, item: item, invoice: invoice)
    transaction = create(:transaction, invoice: invoice, updated_at: "2012-03-27 14:53:59 UTC")
    id = transaction.id
    updated_at = transaction.updated_at

    get "/api/v1/transactions/find?updated_at=#{updated_at}"

    invoice_item = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice_item["data"]["id"].to_i).to eq(id)
  end


    it "can find all transactions by id" do
      merchant = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant: merchant)
      invoice = create(:invoice, customer: customer, merchant: merchant)
      id = create(:transaction, invoice: invoice).id

      get "/api/v1/transactions/find_all?id=#{id}"

      transactions = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(transactions[0]["id"].to_i).to eq(id)
    end

    it "can find all transactions by invoice id" do
      merchant = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant: merchant)
      invoice = create(:invoice, customer: customer, merchant: merchant)
      id = create(:transaction, invoice: invoice).id
      invoice_id = invoice.id

      get "/api/v1/transactions/find_all?invoice_id=#{invoice_id}"

      transactions = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(transactions[0]["id"].to_i).to eq(id)
    end

    it "can find all transactions by credit card number" do
      merchant = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant: merchant)
      invoice = create(:invoice, customer: customer, merchant: merchant)
      cc = create(:transaction, invoice: invoice).credit_card_number

      get "/api/v1/transactions/find_all?credit_card_number=#{cc}"

      transactions = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(transactions[0]["attributes"]["credit_card_number"]).to eq(cc)
    end

    it "can find all transactions by result" do
      merchant = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant: merchant)
      invoice = create(:invoice, customer: customer, merchant: merchant)
      result = create(:transaction, invoice: invoice).result

      get "/api/v1/transactions/find_all?result=#{result}"

      transactions = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(transactions[0]["attributes"]["result"]).to eq(result)
    end

    it "can find all transactions item by created_at timestamp" do
      merchant = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant: merchant)
      invoice = create(:invoice, customer: customer, merchant: merchant)
      invoice_item = create(:invoice_item, item: item, invoice: invoice)
      transaction = create(:transaction, invoice: invoice, created_at: "2012-03-27 14:53:59 UTC")
      id = transaction.id
      created_at = transaction.created_at

      get "/api/v1/transactions/find_all?created_at=#{created_at}"

      transaction = JSON.parse(response.body)["data"]

      expect(response).to be_successful
      expect(transaction[0]["id"].to_i).to eq(id)
    end

    it "can find all transactions item by updated_at timestamp" do
      merchant = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant: merchant)
      invoice = create(:invoice, customer: customer, merchant: merchant)
      invoice_item = create(:invoice_item, item: item, invoice: invoice)
      transaction = create(:transaction, invoice: invoice, updated_at: "2012-03-27 14:53:59 UTC")
      id = transaction.id
      updated_at = transaction.updated_at

      get "/api/v1/transactions/find_all?updated_at=#{updated_at}"

      transaction = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(transaction[0]["id"].to_i).to eq(id)
    end

    it 'displays the associated invoice' do
      merchant = create(:merchant)
      customer = create(:customer)
      item = create(:item, merchant: merchant)
      invoice = create(:invoice, customer: customer, merchant: merchant)
      invoice_item = create(:invoice_item, item: item, invoice: invoice)
      transaction = create(:transaction, invoice: invoice, updated_at: "2012-03-27 14:53:59 UTC")
      id = transaction.id
      updated_at = transaction.updated_at
      invoice_id = invoice.id

      get "/api/v1/transactions/#{id}/invoice"

      invoice = JSON.parse(response.body)["data"]
      expect(response).to be_successful
      expect(invoice["type"]).to eq("invoice")
      expect(invoice["id"].to_i).to eq(invoice_id)
    end
end
