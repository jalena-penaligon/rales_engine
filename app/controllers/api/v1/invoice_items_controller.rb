class Api::V1::InvoiceItemsController < ApplicationController

  def index
    render json: InvoiceItemsSerializer.new(InvoiceItem.all)
  end

  def show
    render json: InvoiceItemsSerializer.new(InvoiceItem.find(params[:id]))
  end

end
