require 'spec_helper'

describe Episode do
  let(:genre) { Genre.new('Drama') }
  let(:episode) { described_class.new(1, 1, 1) }

  it 'episode is viewable' do
    expect(episode.is_viewable).to eq(true)
  end
end
