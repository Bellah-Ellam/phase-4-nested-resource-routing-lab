class ItemsController < ApplicationController

  def index
    user = User.find_by(id: params[:user_id])
    if user
      items = user.items.includes(:user)
      render json: items, include: :user
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end

  def show
    user = User.find_by(id: params[:user_id])
    if user
      item = user.items.find_by(id: params[:id])
      if item
        render json: item, include: :user
      else
        render json: { error: "Item not found" }, status: :not_found
      end
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end

  def create
    user = User.find_by(id: params[:user_id])
    if user
      if params[:item].present?
        item = user.items.build(item_params)
        if item.save
          render json: item, include: :user, status: :created
        else
          render json: { error: item.errors.full_messages }, status: :unprocessable_entity
        end
      else
        render json: { error: "Item data not provided" }, status: :unprocessable_entity
      end
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end
  

  private

  def item_params
    params.require(:item).permit(:name, :description, :price)
  end
end
