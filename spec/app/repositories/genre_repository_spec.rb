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
end
