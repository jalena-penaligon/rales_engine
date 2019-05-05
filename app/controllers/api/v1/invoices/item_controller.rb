class Api::V1::Invoices::ItemController < ApplicationController

  def index
    invoice_items = InvoiceItem.where(invoice_id: params[:id]).pluck(:item_id)
    render json: ItemSerializer.new(Item.where(id: invoice_items))
  end

end
