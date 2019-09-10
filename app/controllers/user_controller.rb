class UserController < ApplicationController
  def me
    render json: current_user
  end
end
