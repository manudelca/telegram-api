require 'spec_helper'
# require_relative '../../../app/persistence/repositories/genre_repo'

describe Persistence::Repositories::ClientRepo do # rubocop:disable RSpec/FilePath
  let(:repository) { described_class.new(DB) }

  describe 'changeset' do
    it 'changeset has email == client.email' do
      client = Client.new('test@test.com', 'test78')
      expect(repository.send(:client_changeset, client)[:email]).to eq \
        client.email
    end

    it 'changeset has username == client.username' do
      client = Client.new('test@test.com', 'test78')
      expect(repository.send(:client_changeset, client)[:username]).to eq \
        client.username
    end
  end

  describe 'save client' do
    it 'must save client' do
      client = Client.new('test@test.com', 'test78')
      saved_client = repository.create_client(client)
      expect(repository.find(saved_client.id).email).to eq client.email
    end
  end

  describe 'find by email' do
    it 'must find client by email' do
      client = Client.new('test@test.com', 'test78')
      repository.create_client(client)
      expect(repository.find_by_email('test@test.com').email).to eq client.email
    end
  end

  describe 'update movie seen' do
    it 'must update movies seen by the client' do
      client = Client.new('test@test3.com', 'test783')
      repository.create_client(client)
      genre = Genre.new('Drama')
      movie = Movie.new('Titanic', 'No ATP', 190, genre, 'USA', 'James Cameron', '2021-01-01', 'Kate Winslet', 'Leonardo Dicaprio')
      Persistence::Repositories::GenreRepo.new(DB).create_genre(genre)
      Persistence::Repositories::MovieRepo.new(DB).create_content(movie)
      client.sees_movie(movie)
      repository.update_movies_seen(client)

      expect(repository.find_by_email('test@test3.com').movies_seen[0].name).to eq movie.name
    end
  end
end
