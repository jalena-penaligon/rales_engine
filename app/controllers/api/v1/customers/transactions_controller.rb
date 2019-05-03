class Api::V1::Customers::TransactionsController < ApplicationController

  def index
    render json: TransactionSerializer.new(Transaction.by_customer(item_params[:id]))
  end

  private

  def item_params
    params.permit(:id)
  end

end
