class HealthController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    render json: { success: true }
  end
end
