require 'rails_helper'

describe Keyword, type: :model do
  it 'should have many keywords users' do
    is_expected.to have_many(:keyword_users)
  end

  it 'should have many users through keywords users' do
    is_expected.to have_many(:users)
  end

  it 'should have many links' do
    is_expected.to have_many(:links)
  end
end
