require 'rails_helper'

describe User, type: :model do
  it 'should validate presence of email' do
    expect(described_class.new(password: 'testpass')).not_to be_valid
  end

  it 'should validate email' do
    expect(described_class.new(email: 'test', password: 'testpass')).not_to be_valid
  end

  it 'should validate presence of password' do
    expect(described_class.new(email: 'test@test.com')).not_to be_valid
  end

  it 'should validate password for six character' do
    expect(described_class.new(email: 'test@test.com', password: 'test')).not_to be_valid
  end

  it 'should create user successfully' do
    expect(described_class.new(email: 'test@test.com', password: 'testpass')).to be_valid
  end
end
