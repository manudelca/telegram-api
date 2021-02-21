require 'spec_helper'

describe Persistence::Repositories::GenericContentRepo do # rubocop:disable RSpec/FilePath
  let(:repository) { described_class.new(DB) }
  let(:movie_repository) { Persistence::Repositories::MovieRepo.new(DB) }

  let(:genre) do
    genre_repository = Persistence::Repositories::GenreRepo.new(DB)
    new_genre = Genre.new('drama')
    genre_repository.create_genre(new_genre)
  end

  after(:each) do
    Persistence::Repositories::MovieRepo.new(DB).delete_all
    Persistence::Repositories::GenreRepo.new(DB).delete_all
  end

  describe 'find by descendant release date' do
    it 'no content returns nil' do
      expect(repository.find_by_desc_release_date(3).nil?).to eq(true)
    end

    it 'when 2 contents, get order by desc release_date' do
      movie_older = Movie.new('Titanic 1', 'No ATP', 190, genre, 'USA', 'James Cameron', '2018-01-01', 'Kate Winslet', 'Leonardo Dicaprio')
      movie_newer = Movie.new('Titanic 2', 'No ATP', 190, genre, 'USA', 'James Cameron', '2019-01-01', 'Kate Winslet', 'Leonardo Dicaprio')

      movie_repository.create_content(movie_older)
      saved_movie_newer = movie_repository.create_content(movie_newer)

      expect(repository.find_by_desc_release_date(3).first.id).to eq(saved_movie_newer.id)
    end
  end
end
