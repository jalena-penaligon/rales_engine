class Api::V1::Merchants::RevenueController < ApplicationController

  def show
    date = search_params["date"]
    render json: RevenueByDaySerializer.new(Invoice.revenue(date)[0])
  end

  private

  def search_params
    search_params = params.permit(:date)
    search_params["date"] = search_params["date"].to_datetime
    search_params
  end

end
