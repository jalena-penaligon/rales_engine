class Api::V1::Merchants::RevenueController < ApplicationController

  def show
    revenue = Merchant.revenue(params[:date])
    render json: RevenueSerializer.new(Revenue.new(Merchant.revenue(params[:date])))
  end

end
