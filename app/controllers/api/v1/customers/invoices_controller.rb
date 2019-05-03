class Api::V1::Customers::InvoicesController < ApplicationController

  def index
    render json: InvoiceSerializer.new(Invoice.where(customer_id: item_params[:id]))
  end

  private

  def item_params
    params.permit(:id)
  end

end
