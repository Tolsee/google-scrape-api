require 'rails_helper'

describe Link::Ad, type: :model do
  let(:keyword) { Fabricate(:keyword) }
  let(:link) { described_class.create(link: 'https://google.com', text: 'helloworld', keyword: keyword) }

  it 'should be of type Ad' do
    expect(link.type).to eq('Link::Ad')
  end
end
