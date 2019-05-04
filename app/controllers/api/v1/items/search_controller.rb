class Api::V1::Items::SearchController < ApplicationController

  def index
    if params["id"]
      render json: ItemSerializer.new(Item.where(id: params[:id]))
    elsif params["name"]
      render json: ItemSerializer.new(Item.where(name: params[:name]))
    elsif params["description"]
      render json: ItemSerializer.new(Item.where(description: params[:description]))
    elsif params["unit_price"]
      unit_price = (params["unit_price"].to_f * 100).round
      render json: ItemSerializer.new(Item.where(unit_price: unit_price))
    elsif params["merchant_id"]
      render json: ItemSerializer.new(Item.where(merchant_id: params[:merchant_id]).order(:id))
    elsif params["created_at"]
      render json: ItemSerializer.new(Item.where(created_at: params[:created_at]))
    elsif params["updated_at"]
      render json: ItemSerializer.new(Item.where(updated_at: params[:updated_at]))
    end
  end

  def show
    if params["id"]
      render json: ItemSerializer.new(Item.find(params[:id]))
    elsif params["name"]
      render json: ItemSerializer.new(Item.find_by(name: params[:name]))
    elsif params["description"]
      render json: ItemSerializer.new(Item.find_by(description: params[:description]))
    elsif params["unit_price"]
      unit_price = (params["unit_price"].to_f * 100).round
      render json: ItemSerializer.new(Item.find_by(unit_price: unit_price))
    elsif params["merchant_id"]
      render json: ItemSerializer.new(Item.find_by(merchant_id: params[:merchant_id]))
    elsif params["created_at"]
      render json: ItemSerializer.new(Item.order(:id).find_by(created_at: params["created_at"].to_datetime))
    elsif params["updated_at"]
      render json: ItemSerializer.new(Item.order(:id).find_by(updated_at: params["updated_at"].to_datetime))
    end
  end
end
