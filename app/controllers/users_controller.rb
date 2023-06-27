class UsersController < ApplicationController

  def show
    user = User.find_by(id: params[:id])
    if user
      render json: user, include: :items
    else
      render json: { error: "User not found" }, status: :not_found
    end
  end


end
