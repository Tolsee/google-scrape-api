require 'rails_helper'

describe KeywordUser, type: :model do
  it 'should belong to user' do
    is_expected.to belong_to(:user)
  end

  it 'should belong to keyword' do
    is_expected.to belong_to(:keyword)
  end
end
