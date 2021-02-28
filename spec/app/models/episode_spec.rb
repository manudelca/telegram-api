require 'spec_helper'

describe Episode do
  let(:genre) { Genre.new('Drama') }
  let(:episode) { described_class.new(1, 1, Time.parse('2020-01-01'), 1) }

  it 'episode is viewable' do
    expect(episode.is_viewable).to eq(true)
  end

  it 'episode is not listable' do
    expect(episode.is_listable).to eq(false)
  end
end
