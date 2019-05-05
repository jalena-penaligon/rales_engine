class Api::V1::InvoiceItems::ItemController < ApplicationController

  def show
    invoice_item = InvoiceItem.find(params[:id])
    render json: ItemSerializer.new(Item.find(invoice_item.item_id))
  end

end
