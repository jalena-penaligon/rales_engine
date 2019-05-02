class Api::V1::Customers::SearchController < ApplicationController

  def index
    if params["id"]
      render json: CustomerSerializer.new(Customer.where(id: params[:id]))
    elsif params["first_name"]
      render json: CustomerSerializer.new(Customer.where(first_name: params[:first_name]))
    elsif params["last_name"]
      render json: CustomerSerializer.new(Customer.where(last_name: params[:last_name]))
    elsif params["created_at"]
      render json: CustomerSerializer.new(Customer.where(created_at: params[:created_at]))
    elsif params["updated_at"]
      render json: CustomerSerializer.new(Customer.where(updated_at: params[:updated_at]))
    end
  end

  def show
    if params["id"]
      render json: CustomerSerializer.new(Customer.find(params[:id]))
    elsif params["first_name"]
      render json: CustomerSerializer.new(Customer.find_by(first_name: params[:first_name]))
    elsif params["last_name"]
      render json: CustomerSerializer.new(Customer.find_by(last_name: params[:last_name]))
    elsif params["created_at"]
      render json: CustomerSerializer.new(Customer.find_by(created_at: params[:created_at]))
    elsif params["updated_at"]
      render json: CustomerSerializer.new(Customer.find_by(updated_at: params[:updated_at]))
    end
  end
end
