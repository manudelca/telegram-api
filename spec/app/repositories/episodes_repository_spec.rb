require 'spec_helper'

describe Persistence::Repositories::EpisodesRepo do # rubocop:disable RSpec/FilePath
  let(:repository) { described_class.new(DB) }

  let(:tv_show) do
    genre_repository = Persistence::Repositories::GenreRepo.new(DB)
    new_genre = Genre.new('drama')
    genre = genre_repository.create_genre(new_genre)

    tv_show_repository = Persistence::Repositories::TvShowRepo.new(DB)
    new_tv_show = TvShow.new('The Office', 'No ATP', 190, genre, 'USA', 'Ricky Gervais', 'Steve Carrell', 'Rainn Wilson')
    tv_show_repository.create_content(new_tv_show)
  end

  after(:each) do
    Persistence::Repositories::ContentRepo.new(DB).delete_all
    Persistence::Repositories::GenreRepo.new(DB).delete_all
  end

  describe 'changeset' do
    it 'changeset has number == episode.number' do
      episode = Episode.new(1, 1, '2021-01-01')
      episode.tv_show = tv_show
      expect(repository.send(:episodes_changeset, episode)[:episode_number]).to eq \
        episode.number
    end

    it 'changeset has tv_show_id == tv_show.id' do
      episode = Episode.new(1, 1, '2021-01-01', tv_show.id)
      episode.tv_show = tv_show
      expect(repository.send(:episodes_changeset, episode)[:tv_show_id]).to eq \
        tv_show.id
    end
  end

  describe 'save episode' do
    it 'must save episode' do
      episode = Episode.new(1, 1, '2021-01-01', tv_show.id)
      episode.tv_show = tv_show
      saved_episode = repository.create_episode(episode)
      expect(repository.find(saved_episode.id).number).to eq episode.number
    end
  end
end
