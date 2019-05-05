class Api::V1::InvoiceItems::InvoiceController < ApplicationController

  def show
    invoice_item = InvoiceItem.find(params[:id])
    render json: InvoiceSerializer.new(Invoice.find(invoice_item.invoice_id))
  end

end
