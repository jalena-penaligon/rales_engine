class Api::V1::Invoices::InvoiceItemController < ApplicationController

  def index
    render json: InvoiceItemsSerializer.new(InvoiceItem.where(invoice_id: params[:id]))
  end

end
