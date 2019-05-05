class Api::V1::Invoices::CustomerController < ApplicationController

  def index
    invoice = Invoice.find(params[:id])
    render json: CustomerSerializer.new(Customer.find(invoice.customer_id))
  end

end
