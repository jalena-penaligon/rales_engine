class Api::V1::InvoiceItems::SearchController < ApplicationController

  def index
    if params["id"]
      render json: InvoiceItemsSerializer.new(InvoiceItem.where(id: params[:id]))
    elsif params["invoice_id"]
      render json: InvoiceItemsSerializer.new(InvoiceItem.order(:id).where(invoice_id: params[:invoice_id]))
    elsif params["item_id"]
      render json: InvoiceItemsSerializer.new(InvoiceItem.where(item_id: params[:item_id]))
    elsif params["quantity"]
      render json: InvoiceItemsSerializer.new(InvoiceItem.where(quantity: params[:quantity]))
    elsif params["unit_price"]
      unit_price = (params["unit_price"].to_f * 100).round
      render json: InvoiceItemsSerializer.new(InvoiceItem.where(unit_price: unit_price))
    elsif params["created_at"]
      render json: InvoiceItemsSerializer.new(InvoiceItem.where(created_at: params[:created_at].to_datetime))
    elsif params["updated_at"]
      render json: InvoiceItemsSerializer.new(InvoiceItem.where(updated_at: params[:updated_at].to_datetime))
    end
  end

  def show
    if params["id"]
      render json: InvoiceItemsSerializer.new(InvoiceItem.find(params[:id]))
    elsif params["invoice_id"]
      render json: InvoiceItemsSerializer.new(InvoiceItem.find_by(invoice_id: params[:invoice_id]))
    elsif params["item_id"]
      render json: InvoiceItemsSerializer.new(InvoiceItem.find_by(item_id: params[:item_id]))
    elsif params["quantity"]
      render json: InvoiceItemsSerializer.new(InvoiceItem.find_by(quantity: params[:quantity]))
    elsif params["unit_price"]
      unit_price = (params["unit_price"].to_f * 100).round
      render json: InvoiceItemsSerializer.new(InvoiceItem.find_by(unit_price: unit_price))
    elsif params["created_at"]
      render json: InvoiceItemsSerializer.new(InvoiceItem.find_by(created_at: params[:created_at].to_datetime))
    elsif params["updated_at"]
      render json: InvoiceItemsSerializer.new(InvoiceItem.find_by(updated_at: params[:updated_at].to_datetime))
    end
  end
end
