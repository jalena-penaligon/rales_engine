class Api::V1::Invoices::SearchController < ApplicationController

  def index
    if params["id"]
      render json: InvoiceSerializer.new(Invoice.where(id: params[:id]))
    elsif params["merchant_id"]
      render json: InvoiceSerializer.new(Invoice.where(merchant_id: params[:merchant_id]))
    elsif params["customer_id"]
      render json: InvoiceSerializer.new(Invoice.order(:id).where(customer_id: params[:customer_id]))
    elsif params["status"]
      render json: InvoiceSerializer.new(Invoice.where(status: params[:status]))
    elsif params["created_at"]
      render json: InvoiceSerializer.new(Invoice.where(created_at: params[:created_at].to_datetime))
    elsif params["updated_at"]
      render json: InvoiceSerializer.new(Invoice.where(updated_at: params[:updated_at].to_datetime))
    end
  end

  def show
    if params["id"]
      render json: InvoiceSerializer.new(Invoice.find(params[:id]))
    elsif params["merchant_id"]
      render json: InvoiceSerializer.new(Invoice.find_by(merchant_id: params[:merchant_id]))
    elsif params["customer_id"]
      render json: InvoiceSerializer.new(Invoice.find_by(customer_id: params[:customer_id]))
    elsif params["status"]
      render json: InvoiceSerializer.new(Invoice.find_by(status: params[:status]))
    elsif params["created_at"]
      render json: InvoiceSerializer.new(Invoice.find_by(created_at: params[:created_at].to_datetime))
    elsif params["updated_at"]
      render json: InvoiceSerializer.new(Invoice.find_by(updated_at: params[:updated_at].to_datetime))
    end
  end
end
