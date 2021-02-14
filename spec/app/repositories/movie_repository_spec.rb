require 'spec_helper'
require_relative '../../../app/persistence/repositories/movie_repo'

describe Persistence::Repositories::MovieRepo do # rubocop:disable RSpec/FilePath
  let(:repository) { described_class.new(DB) }

  describe 'changeset' do
    it 'changeset has name == movie.name' do
      movie = Movie.new(name: 'Titanic')
      expect(repository.send(:movie_changeset, movie)[:name]).to eq \
        movie.name
    end

    it 'changeset has type == movie' do
      movie = Movie.new(name: 'Titanic')
      expect(repository.send(:movie_changeset, movie)[:type]).to eq \
        'movie'
    end
  end

  describe 'save movie' do
    it 'must save movie' do
      movie = Movie.new('Titanic')
      saved_movie = repository.create_content(movie)
      expect(repository.find(saved_movie.id).name).to eq movie.name
    end
  end
end
