require 'rails_helper'

describe Link::Result, type: :model do
  let(:keyword) { Fabricate(:keyword) }
  let(:link) { described_class.create(link: 'https://google.com', text: 'helloworld', keyword: keyword) }

  it 'should have type of Result' do
    expect(link.type).to eq('Link::Result')
  end
end
