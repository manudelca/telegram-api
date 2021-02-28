require 'spec_helper'

describe Persistence::Repositories::ContentRepo do # rubocop:disable RSpec/FilePath
  let(:repository) { described_class.new(DB) }
  let(:movie_repo) { Persistence::Repositories::MovieRepo.new(DB) }
  let(:tv_show_repo) { Persistence::Repositories::TvShowRepo.new(DB) }
  let(:episode_repo) { Persistence::Repositories::EpisodesRepo.new(DB) }

  let(:genre) do
    genre_repository = Persistence::Repositories::GenreRepo.new(DB)
    new_genre = Genre.new('comedy')
    genre_repository.create_genre(new_genre)
  end

  after(:each) do
    described_class.new(DB).delete_all
    Persistence::Repositories::GenreRepo.new(DB).delete_all
  end

  describe 'find movie' do
    it 'find movie' do
      movie = Movie.new('Titanic', 'No ATP', 190, genre, 'USA', 'James Cameron', '2021-01-01', 'Kate Winslet', 'Leonardo Dicaprio')
      saved_movie = movie_repo.create_content(movie)
      expect(repository.find(saved_movie.id).name).to eq movie.name
    end
  end

  describe 'find tv show' do
    it 'find tv show' do
      tv_show = TvShow.new('The Office', 'No ATP', 190, genre, 'USA', 'Ricky Gervais', '2021-01-01', 'Steve Carrell', 'Rainn Wilson')
      saved_tv_show = tv_show_repo.create_content(tv_show)
      expect(repository.find(saved_tv_show.id).name).to eq tv_show.name
    end

    it 'find tv show with episodes' do
      tv_show = TvShow.new('The Office', 'No ATP', 190, genre, 'USA', 'Ricky Gervais', 'Steve Carrell', 'Rainn Wilson')
      saved_tv_show = tv_show_repo.create_content(tv_show)

      episodes_repository = Persistence::Repositories::EpisodesRepo.new(DB)
      episode = Episode.new(1, 1, Time.parse('2021-01-01'))
      episode.tv_show = saved_tv_show
      saved_episode = episodes_repository.create_episode(episode)

      episode_two = Episode.new(2, 1, Time.parse('2021-01-02'))
      episode_two.tv_show = saved_tv_show
      episodes_repository.create_episode(episode_two)

      expect(repository.find(saved_tv_show.id).episodes[0].number).to eq saved_episode.number
    end
  end

  describe 'find by descendant release date' do
    it 'no content returns empty array of contents' do
      expect(repository.find_before_date_and_first_newer(@@date_provider.now).empty?).to eq(true)
    end

    it 'when 2 contents, get order by desc release_date' do
      movie_older = Movie.new('Titanic 1', 'No ATP', 190, genre, 'USA', 'James Cameron', '2018-01-01', 'Kate Winslet', 'Leonardo Dicaprio')
      movie_newer = Movie.new('Titanic 2', 'No ATP', 190, genre, 'USA', 'James Cameron', '2019-01-01', 'Kate Winslet', 'Leonardo Dicaprio')

      movie_repo.create_content(movie_older)
      saved_movie_newer = movie_repo.create_content(movie_newer)

      expect(repository.find_before_date_and_first_newer(@@date_provider.now).first.id).to eq(saved_movie_newer.id)
    end

    it 'when a content release is in future date, find_before_date_and_first_newer dont return it' do
      movie_older = Movie.new('Titanic 1', 'No ATP', 190, genre, 'USA', 'James Cameron', '2018-01-01', 'Kate Winslet', 'Leonardo Dicaprio')
      movie_newer = Movie.new('Titanic 2', 'No ATP', 190, genre, 'USA', 'James Cameron', '2022-01-01', 'Kate Winslet', 'Leonardo Dicaprio')

      movie_repo.create_content(movie_older)
      movie_repo.create_content(movie_newer)

      expect(repository.find_before_date_and_first_newer(@@date_provider.now).size).to eq(1)
    end

    it 'list of contents of different type' do
      movie = Movie.new('Titanic 1', 'No ATP', 190, genre, 'USA', 'James Cameron', '2018-01-01', 'Kate Winslet', 'Leonardo Dicaprio')
      movie_repo.create_content(movie)

      tv_show_repository = Persistence::Repositories::TvShowRepo.new(DB)
      new_tv_show = TvShow.new('The Office', 'No ATP', 190, genre, 'USA', 'Ricky Gervais', 'Steve Carrell', 'Rainn Wilson')
      tv_show = tv_show_repository.create_content(new_tv_show)

      episode = Episode.new(1, 1, Time.parse('2021-01-01'))
      episode.tv_show = tv_show
      episode_repo.create_episode(episode)

      content_matching_find = repository.find_before_date_and_first_newer(@@date_provider.now)
      releases = content_matching_find.select(&:can_be_a_release)
      expect(releases.size).to eq(2)
    end

    it 'when a content release is in future date, find_after_date_and_first_nearer_in_time return it' do
      movie_older = Movie.new('Titanic 1', 'No ATP', 190, genre, 'USA', 'James Cameron', '2018-01-01', 'Kate Winslet', 'Leonardo Dicaprio')
      movie_newer = Movie.new('Titanic 2', 'No ATP', 190, genre, 'USA', 'James Cameron', '2022-01-01', 'Kate Winslet', 'Leonardo Dicaprio')

      movie_repo.create_content(movie_older)
      movie_repo.create_content(movie_newer)

      expect(repository.find_after_date_and_first_nearer_in_time(@@date_provider.now).size).to eq(1)
    end
  end
end
