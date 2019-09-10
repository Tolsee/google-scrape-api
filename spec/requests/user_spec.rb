require 'rails_helper'
require 'devise/jwt/test_helpers'

RSpec.describe UserController, type: %i[request controller] do
  let(:user) { Fabricate(:user) }

  context 'authenticated' do
    before do
      headers = { 'Accept' => 'application/json', 'Content-Type' => 'application/json' }
      auth_headers = Devise::JWT::TestHelpers.auth_headers(headers, user)
      get '/me', headers: auth_headers
    end

    it 'should return authenticated user for me api' do
      expect(JSON.parse(response.body)["id"]).to eq(user.id)
    end

    it 'should return success status' do
      expect(response).to have_http_status(:success)
    end
  end

  context 'unauthenticated' do
    it 'should return error for unauthenticated users' do
      get '/me'

      expect(response).to have_http_status(:unauthorized)
    end
  end
end
