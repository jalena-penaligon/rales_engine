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
end
