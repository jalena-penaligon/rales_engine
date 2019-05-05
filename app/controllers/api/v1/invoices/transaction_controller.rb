class Api::V1::Invoices::TransactionController < ApplicationController

  def index
    render json: TransactionSerializer.new(Transaction.where(invoice_id: params[:id]))
  end

end
