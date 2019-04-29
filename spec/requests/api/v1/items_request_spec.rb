require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    merchant = create(:merchant)
    create_list(:item, 3, merchant: merchant)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)
  end
end
