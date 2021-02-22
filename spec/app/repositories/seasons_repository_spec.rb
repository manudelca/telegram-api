require 'spec_helper'

describe Persistence::Repositories::SeasonsRepo do # rubocop:disable RSpec/FilePath
  let(:repository) { described_class.new(DB) }

  let(:tv_show) do
    genre_repository = Persistence::Repositories::GenreRepo.new(DB)
    new_genre = Genre.new('drama')
    genre = genre_repository.create_genre(new_genre)

    tv_show_repository = Persistence::Repositories::TvShowRepo.new(DB)
    tv_show = TvShow.new('The Office', 'No ATP', 190, genre, 'USA', 'Ricky Gervais', '2021-01-01', 'Steve Carrell', 'Rainn Wilson')
    tv_show_repository.create_content(tv_show)
  end

  after(:each) do
    described_class.new(DB).delete_all
    Persistence::Repositories::TvShowRepo.new(DB).delete_all
    Persistence::Repositories::GenreRepo.new(DB).delete_all
  end

  describe 'changeset' do
    it 'changeset has number == season.number' do
      season = Season.new(1, tv_show.id, '2021-01-01')
      expect(repository.send(:seasons_changeset, season)[:number]).to eq \
        season.number
    end

    it 'changeset has tv_show_id == tv_show.id' do
      season = Season.new(1, tv_show.id, '2021-01-01')
      expect(repository.send(:seasons_changeset, season)[:tv_show_id]).to eq \
        tv_show.id
    end

    it 'changeset has release_date == season.release_date' do
      season = Season.new(1, tv_show.id, '2021-01-01')
      expect(repository.send(:seasons_changeset, season)[:release_date]).to eq \
        season.release_date
    end
  end

  describe 'save seasons' do
    it 'must save season' do
      season = Season.new(1, tv_show.id, '2021-01-01')
      saved_season = repository.find_or_create(season)
      expect(repository.find(saved_season.id).number).to eq season.number
    end
  end

  describe 'update season' do
    it 'update season release_date' do
      season = Season.new(1, tv_show.id, '2021-01-01')
      saved_season = repository.find_or_create(season)
      saved_season.update_release_date('2022-01-01')
      expect(repository.update_season(saved_season).release_date).to eq('2022-01-01')
    end
  end
end
