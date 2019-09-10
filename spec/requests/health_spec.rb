require 'rails_helper'

RSpec.describe HealthController, type: %i[request controller] do
  before do
    get '/health'
  end

  it 'should respond with success true' do
    expect(JSON.parse(response.body)['success']).to eq(true)
  end

  it 'should have status success' do
    expect(response).to have_http_status(:success)
  end
end
