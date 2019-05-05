class Api::V1::Transactions::SearchController < ApplicationController

  def index
    if params["id"]
      render json: TransactionSerializer.new(Transaction.where(id: params[:id]))
    elsif params["invoice_id"]
      render json: TransactionSerializer.new(Transaction.order(:id).where(invoice_id: params[:invoice_id]))
    elsif params["credit_card_number"]
      render json: TransactionSerializer.new(Transaction.where(credit_card_number: params[:credit_card_number]))
    elsif params["result"]
      render json: TransactionSerializer.new(Transaction.where(result: params[:result]))
    elsif params["created_at"]
      render json: TransactionSerializer.new(Transaction.where(created_at: params[:created_at]))
    elsif params["updated_at"]
      render json: TransactionSerializer.new(Transaction.where(updated_at: params[:updated_at]))
    end
  end

  def show
    if params["id"]
      render json: TransactionSerializer.new(Transaction.find(params[:id]))
    elsif params["invoice_id"]
      render json: TransactionSerializer.new(Transaction.find_by(invoice_id: params[:invoice_id]))
    elsif params["credit_card_number"]
      render json: TransactionSerializer.new(Transaction.find_by(credit_card_number: params[:credit_card_number]))
    elsif params["result"]
      render json: TransactionSerializer.new(Transaction.find_by(result: params[:result]))
    elsif params["created_at"]
      render json: TransactionSerializer.new(Transaction.find_by(created_at: params[:created_at]))
    elsif params["updated_at"]
      render json: TransactionSerializer.new(Transaction.find_by(updated_at: params[:updated_at]))
    end
  end

end
