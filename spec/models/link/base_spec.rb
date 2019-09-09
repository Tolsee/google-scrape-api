require 'rails_helper'

describe Link::Base, type: :model do
  it 'should belong to keyword' do
    is_expected.to belong_to(:keyword)
  end
end
