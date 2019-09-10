class ApplicationController < ActionController::API
  before_action :authenticate_user!
  include ActionController::MimeResponds

  include Localization
  respond_to :json
end
