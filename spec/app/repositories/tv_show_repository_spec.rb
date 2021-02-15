require 'spec_helper'
require_relative '../../../app/persistence/repositories/tv_show_repo'

describe Persistence::Repositories::TvShowRepo do # rubocop:disable RSpec/FilePath
  let(:repository) { described_class.new(DB) }
  let(:tv_show) do
    genre = Genre.new('comedy')
    Persistence::Repositories::GenreRepo.new(DB).create_genre(genre)

    tv_show = TvShow.new('The Office', "No ATP", 190, genre, 'USA', 'Ricky Gervais', '2021-01-01', 'Steve Carrell', 'Rainn Wilson')
  end

  describe 'changeset' do
    it 'changeset has name == movie.name' do
      expect(repository.send(:tv_show_changeset, tv_show)[:name]).to eq \
        tv_show.name
    end

    it 'changeset has type == tv_show' do
      expect(repository.send(:tv_show_changeset, tv_show)[:type]).to eq \
        'tv_show'
    end
  end

  describe 'save tv show' do
    it 'must save tv show' do
      saved_tv_show = repository.create_content(tv_show)
      expect(repository.find(saved_tv_show.id).name).to eq tv_show.name
    end
  end
end
