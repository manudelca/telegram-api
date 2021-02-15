require 'spec_helper'

describe Persistence::Repositories::MovieRepo do # rubocop:disable RSpec/FilePath
  let(:repository) { described_class.new(DB) }
  let(:movie) do
    genre = Genre.new('drama')
    Persistence::Repositories::GenreRepo.new(DB).create_genre(genre)

    Movie.new('Titanic', 'No ATP', 190, genre, 'USA', 'James Cameron', '2021-01-01', 'Kate Winslet', 'Leonardo Dicaprio')
  end

  describe 'changeset' do
    it 'changeset has name == movie.name' do
      expect(repository.send(:movie_changeset, movie)[:name]).to eq \
        movie.name
    end

    it 'changeset has type == movie' do
      expect(repository.send(:movie_changeset, movie)[:type]).to eq \
        'movie'
    end
  end

  describe 'save movie' do
    it 'must save movie' do
      saved_movie = repository.create_content(movie)
      expect(repository.find(saved_movie.id).name).to eq movie.name
    end
  end
end
