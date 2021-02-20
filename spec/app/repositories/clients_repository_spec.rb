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

    it 'changeset has telegram_user_id == client.telegram_user_id' do
      client = Client.new('test@test.com', 123_789_456)
      expect(repository.send(:client_changeset, client)[:telegram_user_id]).to eq \
        client.telegram_user_id
    end
  end

  describe 'save client' do
    it 'must save client' do
      client = Client.new('test@test.com', 123_789_456)
      saved_client = repository.create_client(client)
      expect(repository.find(saved_client.id).email).to eq client.email
    end
  end

  describe 'find by telegram_user_id' do
    it 'must find client by telegram_user_id' do
      client = Client.new('test@test.com', 123_789_456)
      repository.create_client(client)
      expect(repository.find_by_telegram_user_id(123_789_456).telegram_user_id).to eq client.telegram_user_id
    end
  end

  describe 'update movie seen' do
    it 'must update movies seen by the client' do
      client = Client.new('test@test3.com', 456_345)
      repository.create_client(client)
      genre = Genre.new('Drama')
      movie = Movie.new('Titanic', 'No ATP', 190, genre, 'USA', 'James Cameron', '2021-01-01', 'Kate Winslet', 'Leonardo Dicaprio')
      Persistence::Repositories::GenreRepo.new(DB).create_genre(genre)
      Persistence::Repositories::MovieRepo.new(DB).create_content(movie)
      client.sees_movie(movie)
      repository.update_movies_seen(client)

      expect(repository.find_by_telegram_user_id(456_345).movies_seen[0].name).to eq movie.name
    end
  end

  describe 'update episode seen' do
    xit 'must update episodes seen by the client' do
      client = Client.new('test@test3.com', 456_345)
      repository.create_client(client)
      genre = Genre.new('Drama')
      Persistence::Repositories::GenreRepo.new(DB).create_genre(genre)
      tv_show = TvShow.new('Titanic', 'ATP', 195, genre, 'USA', 'James Cameron', 'Kate Winslet', 'Leonardo Dicaprio')
      new_tv_show = Persistence::Repositories::TvShowRepo.new(DB).create_content(tv_show)
      season = Season.new(1, new_tv_show.id)
      new_season = Persistence::Repositories::SeasonsRepo.new(DB).create_season(season)
      episode = Episode.new(1, new_season.id)
      new_episode = Persistence::Repositories::EpisodesRepo.new(DB).create_episode(episode)
      client.sees_episode(episode)
      repository.update_episodes_seen(client)

      expect(repository.find_by_telegram_user_id(456_345).episodes_seen[0].id).to eq new_episode.id
    end
  end

  describe 'update movie liked' do
    it 'must update movies liked by the client' do
      client = Client.new('test@test5.com', 978_567)
      repository.create_client(client)
      genre = Genre.new('Drama')
      movie = Movie.new('Titanic', 'No ATP', 190, genre, 'USA', 'James Cameron', '2021-01-01', 'Kate Winslet', 'Leonardo Dicaprio')
      Persistence::Repositories::GenreRepo.new(DB).create_genre(genre)
      Persistence::Repositories::MovieRepo.new(DB).create_content(movie)
      client.sees_movie(movie)
      repository.update_movies_seen(client)
      client.likes(movie)
      repository.update_contents_liked(client)

      expect(repository.find_by_telegram_user_id(978_567).content_liked[0].name).to eq movie.name
    end
  end
end
