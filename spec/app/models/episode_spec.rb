require 'spec_helper'

describe Episode do
  let(:genre) { Genre.new('Drama') }
  let(:episode) { described_class.new(1, 1, '2020-01-01', 1) }

  it 'episode is viewable' do
    expect(episode.is_viewable).to eq(true)
  end

  it 'episode is not listable' do
    expect(episode.is_listable).to eq(false)
  end

  it 'episode tells if it was released' do
    expect(episode.was_released?(Time.parse('2021-01-01'))).to eq(true)
  end
end
