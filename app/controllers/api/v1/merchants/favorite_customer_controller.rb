class Api::V1::Merchants::FavoriteCustomerController < ApplicationController

  def show
    merchant = Merchant.find(params[:id])
    render json: CustomerSerializer.new(Customer.favorite_customer_of(merchant)[0])
  end

end
