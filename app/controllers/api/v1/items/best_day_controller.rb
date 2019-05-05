class Api::V1::Items::BestDayController < ApplicationController

  def show
    render json: BestDaySerializer.new(Item.best_day(params[:id])[0])
  end

end
