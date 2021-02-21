require 'spec_helper'

describe Persistence::Repositories::EpisodesRepo do # rubocop:disable RSpec/FilePath
  let(:repository) { described_class.new(DB) }

  let(:season) do
    genre_repository = Persistence::Repositories::GenreRepo.new(DB)
    new_genre = Genre.new('drama')
    genre = genre_repository.create_genre(new_genre)

    tv_show_repository = Persistence::Repositories::TvShowRepo.new(DB)
    new_tv_show = TvShow.new('The Office', 'No ATP', 190, genre, 'USA', 'Ricky Gervais', '2021-01-01', 'Steve Carrell', 'Rainn Wilson')
    tv_show = tv_show_repository.create_content(new_tv_show)

    seasons_repository = Persistence::Repositories::SeasonsRepo.new(DB)
    new_season = Season.new(1, tv_show.id, '2021-01-01')
    seasons_repository.create_season(new_season)
  end

  after(:each) do
    described_class.new(DB).delete_all
    Persistence::Repositories::SeasonsRepo.new(DB).delete_all
    Persistence::Repositories::TvShowRepo.new(DB).delete_all
    Persistence::Repositories::GenreRepo.new(DB).delete_all
  end

  describe 'changeset' do
    it 'changeset has number == episode.number' do
      episode = Episode.new(1, season.id)
      expect(repository.send(:episodes_changeset, episode)[:number]).to eq \
        episode.number
    end

    it 'changeset has season_id == season.id' do
      episode = Episode.new(1, season.id)
      expect(repository.send(:episodes_changeset, episode)[:season_id]).to eq \
        season.id
    end
  end

  describe 'save episode' do
    it 'must save episode' do
      episode = Episode.new(1, season.id)
      saved_episode = repository.create_episode(episode)
      expect(repository.find(saved_episode.id).number).to eq episode.number
    end
  end
end
