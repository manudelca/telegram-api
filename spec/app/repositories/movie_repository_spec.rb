require 'spec_helper'

describe Persistence::Repositories::MovieRepo do # rubocop:disable RSpec/FilePath
  let(:repository) { described_class.new(DB) }

  let(:genre) do
    genre_repository = Persistence::Repositories::GenreRepo.new(DB)
    new_genre = Genre.new('drama')
    genre_repository.create_genre(new_genre)
  end

  after(:each) do
    described_class.new(DB).delete_all
    Persistence::Repositories::GenreRepo.new(DB).delete_all
  end

  describe 'changeset' do
    it 'changeset has name == movie.name' do
      movie = Movie.new('Titanic', 'No ATP', 190, genre, 'USA', 'James Cameron', '2021-01-01', 'Kate Winslet', 'Leonardo Dicaprio')
      expect(repository.send(:movie_changeset, movie)[:name]).to eq \
        movie.name
    end

    it 'changeset has type == movie' do
      movie = Movie.new('Titanic', 'No ATP', 190, genre, 'USA', 'James Cameron', '2021-01-01', 'Kate Winslet', 'Leonardo Dicaprio')
      expect(repository.send(:movie_changeset, movie)[:type]).to eq \
        'movie'
    end
  end

  describe 'save movie' do
    it 'must save movie' do
      movie = Movie.new('Titanic', 'No ATP', 190, genre, 'USA', 'James Cameron', '2021-01-01', 'Kate Winslet', 'Leonardo Dicaprio')
      saved_movie = repository.create_content(movie)
      expect(repository.find(saved_movie.id).name).to eq movie.name
    end
  end

  describe 'find movie' do
    it 'find none existant movie raise ContentNotFound' do
      non_existant_movie_id = -1
      expect { repository.find(non_existant_movie_id) }.to raise_error(ContentNotFound)
    end
  end
end
