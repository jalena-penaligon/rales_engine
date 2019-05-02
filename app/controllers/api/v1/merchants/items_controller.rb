class Api::V1::Merchants::ItemsController < ApplicationController

  def index
    render json: ItemSerializer.new(Item.where(merchant_id: item_params[:id]))
  end

  private

  def item_params
    params.permit(:id)
  end

end
