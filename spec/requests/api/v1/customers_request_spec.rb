require 'rails_helper'

describe "Customers API" do
  it "sends a list of customers" do
    create_list(:customer, 3)

    get '/api/v1/customers'

    expect(response).to be_successful

    customers = JSON.parse(response.body)["data"]
    expect(customers.count).to eq(3)
  end

  it "can show a customer by id" do
    id = create(:customer).id

    get "/api/v1/customers/#{id}"

    customer = JSON.parse(response.body)["data"]
    expect(response).to be_successful
    expect(customer["id"].to_i).to eq(id)
  end

  it "can find a customer by id" do
    id = create(:customer).id

    get "/api/v1/customers/find?id=#{id}"

    customer = JSON.parse(response.body)
    expect(response).to be_successful
    expect(customer["data"]["id"].to_i).to eq(id)
  end

  it "can find a customer by first name" do
    first_name = create(:customer).first_name

    get "/api/v1/customers/find?first_name=#{first_name}"

    customer = JSON.parse(response.body)
    expect(response).to be_successful
    expect(customer["data"]["attributes"]["first_name"]).to eq(first_name)
  end

  it "can find a customer by last name" do
    last_name = create(:customer).last_name

    get "/api/v1/customers/find?last_name=#{last_name}"

    customer = JSON.parse(response.body)
    expect(response).to be_successful
    expect(customer["data"]["attributes"]["last_name"]).to eq(last_name)
  end

  it "can find a customer by created at" do
    first_name = create(:customer, created_at: "2012-03-25 09:54:09 UTC").first_name

    get "/api/v1/customers/find?created_at=2012-03-25 09:54:09 UTC"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["data"]["attributes"]["first_name"]).to eq(first_name)
  end

  it "can find a customer by updated at" do
    first_name = create(:customer, updated_at: "2012-03-25 09:54:09 UTC").first_name

    get "/api/v1/customers/find?updated_at=2012-03-25 09:54:09 UTC"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["data"]["attributes"]["first_name"]).to eq(first_name)
  end

  it "can find all customers by id" do
    id = create(:customer).id

    get "/api/v1/customers/find_all?id=#{id}"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["data"][0]["id"].to_i).to eq(id)
  end

  it "can find all customers by first_name" do
    first_name = create(:customer).first_name
    create(:customer, first_name: first_name)

    get "/api/v1/customers/find_all?first_name=#{first_name}"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["data"].count).to eq(2)
    expect(customer["data"][0]["attributes"]["first_name"]).to eq(first_name)
  end

  it "can find all customers by last_name" do
    last_name = create(:customer).last_name
    create(:customer, last_name: last_name)

    get "/api/v1/customers/find_all?last_name=#{last_name}"

    customer = JSON.parse(response.body)

    expect(response).to be_successful
    expect(customer["data"].count).to eq(2)
    expect(customer["data"][0]["attributes"]["last_name"]).to eq(last_name)
  end

  it "can find all customers by created_at" do
    first_name = create(:customer, created_at: "2012-03-25 09:54:09 UTC").first_name
    create(:customer, created_at: "2012-03-25 09:54:09 UTC")

    get "/api/v1/customers/find_all?created_at=2012-03-25 09:54:09 UTC"

    customer = JSON.parse(response.body)

    expect(response).to be_successful

    expect(customer["data"].count).to eq(2)
    expect(customer["data"][0]["attributes"]["first_name"]).to eq(first_name)
  end

  it "can find all customers by updated_at" do
    first_name = create(:customer, updated_at: "2012-03-25 09:54:09 UTC").first_name
    create(:customer, updated_at: "2012-03-25 09:54:09 UTC")

    get "/api/v1/customers/find_all?updated_at=2012-03-25 09:54:09 UTC"

    customer = JSON.parse(response.body)

    expect(response).to be_successful

    expect(customer["data"].count).to eq(2)
    expect(customer["data"][0]["attributes"]["first_name"]).to eq(first_name)
  end

  it "can show all invoices for a given customer" do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice_1 = create(:invoice, merchant: merchant, customer: customer)
    invoice_2 = create(:invoice, merchant: merchant, customer: customer)
    invoice_3 = create(:invoice, merchant: merchant, customer: customer)

    id = customer.id

    get "/api/v1/customers/#{id}/invoices"

    invoices = JSON.parse(response.body)["data"]

    expect(response).to be_successful

    expect(invoices[0].count).to eq(3)
    expect(invoices[0]["type"]).to eq("invoice")
  end

  it "can show all transactions for a given customer" do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice_1 = create(:invoice, merchant: merchant, customer: customer)
    invoice_2 = create(:invoice, merchant: merchant, customer: customer)
    invoice_3 = create(:invoice, merchant: merchant, customer: customer)

    transaction_1 = create(:transaction, invoice: invoice_1)
    transaction_2 = create(:transaction, invoice: invoice_2)
    transaction_3 = create(:transaction, invoice: invoice_3)

    id = customer.id

    get "/api/v1/customers/#{id}/transactions"

    invoices = JSON.parse(response.body)["data"]

    expect(response).to be_successful

    expect(invoices[0].count).to eq(3)
    expect(invoices[0]["type"]).to eq("transaction")
  end
end
