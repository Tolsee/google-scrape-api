class ApplicationController < ActionController::API
  include ActionController::MimeResponds

  include Localization
  respond_to :json
end
