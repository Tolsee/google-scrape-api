class ApplicationController < ActionController::Base
  respond_to :json

  include Localization
end
