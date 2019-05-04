class Api::V1::Customers::FavoriteMerchantController < ApplicationController

  def show
    customer = Customer.find(params[:id])
    render json: MerchantSerializer.new(Merchant.favorite_merchant_of(customer)[0])
  end

end
