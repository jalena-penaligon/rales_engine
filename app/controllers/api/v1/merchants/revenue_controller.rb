class Api::V1::Merchants::RevenueController < ApplicationController

  def show
    merchant = Merchant.find(merchant_params[:id])
    if params["date"] == nil
      render json: RevenueSerializer.new(Invoice.revenue_for(merchant)[0])
    else
      render json: RevenueSerializer.new(Invoice.revenue_by_date_for(merchant, date_params["date"])[0])
    end
  end

  def index
    date = date_params["date"]
    render json: RevenueByDaySerializer.new(Invoice.revenue(date)[0])
  end

  private

  def merchant_params
    params.permit(:id)
  end

  def date_params
    search_params = params.permit(:date)
    search_params["date"] = search_params["date"].to_datetime
    search_params
  end

end
