require 'rails_helper'

describe "Invoices API" do
  it "sends a list of invoices" do
    customer = create(:customer)
    merchant = create(:merchant)
    create_list(:invoice, 3, customer: customer, merchant: merchant)

    get '/api/v1/invoices'

    expect(response).to be_successful

    invoices = JSON.parse(response.body)
    expect(invoices.count).to eq(3)
  end

  it "can show invoices by id" do
    customer = create(:customer)
    merchant = create(:merchant)
    id = create(:invoice, customer: customer, merchant: merchant).id

    get "/api/v1/invoices/#{id}"

    invoice = JSON.parse(response.body)
    expect(response).to be_successful
    expect(invoice["id"]).to eq(id)
  end
end
