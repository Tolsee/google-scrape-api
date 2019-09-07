require 'rails_helper'

describe JwtBlacklist, type: :model do
  it 'should create jwt_blacklist successfully' do
    expect(described_class.new(jti: 'test', exp: Time.zone.now)).to be_valid
  end
end
