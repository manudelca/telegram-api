require 'spec_helper'

describe Persistence::Repositories::EpisodesRepo do # rubocop:disable RSpec/FilePath
  let(:repository) { described_class.new(DB) }

  let(:season) do
    tv_show = TvShow.new('Titanic')
    new_tv_show = Persistence::Repositories::TvShowRepo.new(DB).create_content(tv_show)

    season = Season.new(new_tv_show, 1)
    Persistence::Repositories::SeasonsRepo.new(DB).create_season(season)
  end

  describe 'changeset' do
    it 'changeset has number == episode.number' do
      episode = Episode.new(season, 1)
      expect(repository.send(:episodes_changeset, episode)[:number]).to eq \
        episode.number
    end

    it 'changeset has season_id == season.id' do
      episode = Episode.new(season, 1)
      expect(repository.send(:episodes_changeset, episode)[:season_id]).to eq \
        season.id
    end
  end

  describe 'save episode' do
    it 'must save episode' do
      episode = Episode.new(season, 1)
      saved_episode = repository.create_episode(episode)
      expect(repository.find(saved_episode.id).number).to eq episode.number
    end
  end
end
