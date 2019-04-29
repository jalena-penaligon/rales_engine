require 'rails_helper'

describe "Invoices API" do
  it "sends a list of invoices" do
    customer = create(:customer)
    create_list(:invoice, 3, customer: customer)

    get '/api/v1/invoices'

    expect(response).to be_successful

    invoices = JSON.parse(response.body)
  end
end
