class Api::V1::Invoices::MerchantController < ApplicationController

  def index
    invoice = Invoice.find(params[:id])
    render json: MerchantSerializer.new(Merchant.find(invoice.merchant_id))
  end

end
