require 'spec_helper'
require_relative '../../../app/persistence/repositories/genre_repo'

describe Persistence::Repositories::GenreRepo do # rubocop:disable RSpec/FilePath
  let(:repository) { described_class.new(DB) }

  describe 'changeset' do
    it 'changeset has name == genre.name' do
      genre = Genre.new(name: 'comedy')
      expect(repository.send(:genre_changeset, genre)[:name]).to eq \
        genre.name
    end
  end

  describe 'save genre' do
    it 'must save genre' do
      new_genre = Genre.new('comedy')
      saved_genre = repository.create_genre(new_genre)
      expect(repository.find(saved_genre.id).name).to eq new_genre.name
    end
  end
end
