require 'spec_helper'

describe Persistence::Repositories::EpisodesRepo do # rubocop:disable RSpec/FilePath
  let(:repository) { described_class.new(DB) }

  describe 'changeset' do
    it 'changeset has number == episode.number' do
      episode = Episode.new(1)
      expect(repository.send(:episodes_changeset, episode)[:number]).to eq \
        episode.number
    end
  end

  describe 'save episode' do
    it 'must save episode' do
      episode = Episode.new(1)
      saved_episode = repository.create_episode(episode)
      expect(repository.find(saved_episode.id).number).to eq episode.number
    end
  end
end
