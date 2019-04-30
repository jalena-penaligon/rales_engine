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
    id = create(:merchant).id

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
end
