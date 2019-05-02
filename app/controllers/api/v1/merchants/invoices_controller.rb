class Api::V1::Merchants::InvoicesController < ApplicationController

  def index
    render json: InvoiceSerializer.new(Invoice.where(merchant_id: item_params[:id]))
  end

  private

  def item_params
    params.permit(:id)
  end

end
