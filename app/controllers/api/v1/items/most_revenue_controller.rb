class Api::V1::Items::MostRevenueController < ApplicationController

  def show
    render json: ItemSerializer.new(Item.most_revenue(params[:quantity]))
  end

end
