require 'spec_helper'
require_relative '../../../app/persistence/repositories/tv_show_repo'

describe Persistence::Repositories::TvShowRepo do # rubocop:disable RSpec/FilePath
  let(:repository) { described_class.new(DB) }

  let(:genre) do
    genre_repository = Persistence::Repositories::GenreRepo.new(DB)
    new_genre = Genre.new('comedy')
    genre_repository.create_genre(new_genre)
  end

  after(:each) do
    described_class.new(DB).delete_all
    Persistence::Repositories::GenreRepo.new(DB).delete_all
  end

  describe 'changeset' do
    it 'changeset has name == movie.name' do
      tv_show = TvShow.new('The Office', 'No ATP', 190, genre, 'USA', 'Ricky Gervais', '2021-01-01', 'Steve Carrell', 'Rainn Wilson')
      expect(repository.send(:tv_show_changeset, tv_show)[:name]).to eq \
        tv_show.name
    end

    it 'changeset has type == tv_show' do
      tv_show = TvShow.new('The Office', 'No ATP', 190, genre, 'USA', 'Ricky Gervais', '2021-01-01', 'Steve Carrell', 'Rainn Wilson')
      expect(repository.send(:tv_show_changeset, tv_show)[:type]).to eq \
        'tv_show'
    end
  end

  describe 'save tv show' do
    it 'must save tv show' do
      tv_show = TvShow.new('The Office', 'No ATP', 190, genre, 'USA', 'Ricky Gervais', '2021-01-01', 'Steve Carrell', 'Rainn Wilson')
      saved_tv_show = repository.create_content(tv_show)
      expect(repository.find(saved_tv_show.id).name).to eq tv_show.name
    end
  end
end
