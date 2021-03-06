require 'spec_helper'

describe Client do
  let(:client) { described_class.new('juan@test.com', 123) }
  let(:repository) { Persistence::Repositories::ClientRepo.new(DB) }

  describe 'sees content' do
    it 'should be able to mark movies as seen' do
      genre = Genre.new('Drama')
      movie_id = 0
      movie = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', Time.parse('2021-01-01'), 'Leonardo Di Caprio', 'Kate', movie_id)
      Persistence::Repositories::GenreRepo.new(DB).create_genre(genre)
      Persistence::Repositories::MovieRepo.new(DB).create_content(movie)
      today = Time.parse('2021-01-02')
      date_provider = DateProvider.new
      date_provider.define_now_date(today)
      client.sees_content(movie, date_provider, repository)

      expect(client.saw_content?(movie)).to eq(true)
    end

    it 'should seen episodes' do
      genre = Genre.new('Comedy')
      id = 0
      tv_show = TvShow.new('Titanic: La serie', 'ATP', 190, genre, 'USA', 'James Cameron', 'Leonardo Di Caprio', 'Kate', id)
      new_tv_show = Persistence::Repositories::TvShowRepo.new(DB).create_content(tv_show)
      episode = Episode.new(1, 1, Time.parse('2021-01-01'))
      episode.tv_show = new_tv_show
      Persistence::Repositories::EpisodesRepo.new(DB).create_episode(episode)
      today = Time.parse('2021-01-02')
      date_provider = DateProvider.new
      date_provider.define_now_date(today)
      client.sees_content(episode, date_provider, repository)

      expect(client.saw_content?(episode)).to eq(true)
    end

    it 'should raise error when seen a non-viewable content' do
      genre = Genre.new('Comedy')
      id = 0
      tv_show = TvShow.new('Titanic: La serie', 'ATP', 190, genre, 'USA', 'James Cameron', 'Leonardo Di Caprio', 'Kate', id)
      new_tv_show = Persistence::Repositories::TvShowRepo.new(DB).create_content(tv_show)
      seen_date = Time.parse('2021-01-05')
      date_provider = DateProvider.new
      date_provider.define_now_date(seen_date)

      expect { client.sees_content(new_tv_show, date_provider, repository) }.to raise_error(NotViewableContentError)
    end

    it 'should not be able to mark content as seen if it is not released' do
      genre = Genre.new('Comedy')
      id = 0
      tv_show = TvShow.new('Titanic: La serie', 'ATP', 190, genre, 'USA', 'James Cameron', 'Leonardo Di Caprio', 'Kate', id)
      new_tv_show = Persistence::Repositories::TvShowRepo.new(DB).create_content(tv_show)
      episode = Episode.new(1, 1, Time.parse('2021-01-05'))
      episode.tv_show = new_tv_show
      Persistence::Repositories::EpisodesRepo.new(DB).create_episode(episode)
      today = Time.parse('2021-01-02')
      date_provider = DateProvider.new
      date_provider.define_now_date(today)

      expect { client.sees_content(episode, date_provider, repository) }.to raise_error(ContentNotReleasedError)
    end
  end

  describe 'likes content' do
    it 'should be able to mark content as liked' do
      genre = Genre.new('Drama')
      movie_id = 0
      movie = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', Time.parse('2020-01-01'), 'Leonardo Di Caprio', 'Kate', movie_id)
      Persistence::Repositories::GenreRepo.new(DB).create_genre(genre)
      Persistence::Repositories::MovieRepo.new(DB).create_content(movie)
      today = Time.parse('2021-01-02')
      date_provider = DateProvider.new
      date_provider.define_now_date(today)
      client.sees_content(movie, date_provider, repository)
      client.likes(movie, repository)

      expect(client.liked_content?(movie)).to eq(true)
    end

    it 'should not be able to mark content not seen as liked' do
      genre = Genre.new('Drama')
      movie_id = 0
      movie = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', Time.parse('2020-01-01'), 'Leonardo Di Caprio', 'Kate', movie_id)
      Persistence::Repositories::GenreRepo.new(DB).create_genre(genre)
      Persistence::Repositories::MovieRepo.new(DB).create_content(movie)

      expect { client.likes(movie, repository) }.to raise_error(ContentNotSeenError)
    end

    it 'should add a liked content' do
      genre = Genre.new('Drama')
      movie_id = 0
      movie = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', Time.parse('2020-01-01'), 'Leonardo Di Caprio', 'Kate', movie_id)
      Persistence::Repositories::GenreRepo.new(DB).create_genre(genre)
      Persistence::Repositories::MovieRepo.new(DB).create_content(movie)
      client.add_liked_content(movie)

      expect(client.liked_content?(movie)).to eq(true)
    end

    it 'should be able to mark tv show as liked' do # rubocop:disable RSpec/ExampleLength
      genre = Genre.new('Drama')
      tv_show = TvShow.new('Titanic: La serie', 'ATP', 190, genre, 'USA', 'James Cameron', 'Leonardo Di Caprio', 'Kate')
      new_tv_show = Persistence::Repositories::TvShowRepo.new(DB).create_content(tv_show)
      today = Time.parse('2021-01-02')
      date_provider = DateProvider.new
      date_provider.define_now_date(today)
      episodes = []
      episodes << Episode.new(1, 1, today, 1)
      episodes << Episode.new(2, 1, today, 2)
      episodes << Episode.new(3, 1, today, 3)
      client_repository = instance_double('Persistence::Repositories::ClientRepo')
      allow(client_repository).to receive(:update_contents_seen).and_return(nil)
      allow(client_repository).to receive(:update_contents_liked).and_return(nil)
      tv_show.episodes = episodes
      client.sees_content(episodes[0], date_provider, client_repository)
      client.sees_content(episodes[1], date_provider, client_repository)
      client.sees_content(episodes[2], date_provider, client_repository)
      client.likes(episodes[0], client_repository)
      client.likes(episodes[1], client_repository)
      client.likes(episodes[2], client_repository)
      client.likes(new_tv_show, client_repository)

      expect(client.liked_content?(new_tv_show)).to eq(true)
    end

    it 'should not be able to mark content as liked when already liked' do
      genre = Genre.new('Drama')
      movie = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', Time.parse('2020-01-01'), 'Leonardo Di Caprio', 'Kate')
      Persistence::Repositories::GenreRepo.new(DB).create_genre(genre)
      Persistence::Repositories::MovieRepo.new(DB).create_content(movie)

      today = Time.parse('2021-01-02')
      date_provider = DateProvider.new
      date_provider.define_now_date(today)
      client.sees_content(movie, date_provider, repository)
      client.likes(movie, repository)

      saved_movie = Persistence::Repositories::ContentRepo.new(DB).find(movie.id)
      expect { client.likes(saved_movie, repository) }.to raise_error(ContentAlreadyLikedError)
    end
  end

  describe 'validation' do
    it 'should raise exception if initialized with nil email' do
      email = nil
      telegram_user_id = 1
      expect { described_class.new(email, telegram_user_id) }.to raise_error(NoEmailError)
    end
  end

  describe 'seen this week' do
    it 'should return movie seen yesterday when asking for content seen this week' do
      genre = Genre.new('Drama')
      movie_id = 0
      movie = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', Time.parse('2020-01-01'), 'Leonardo Di Caprio', 'Kate', movie_id)
      Persistence::Repositories::GenreRepo.new(DB).create_genre(genre)
      Persistence::Repositories::MovieRepo.new(DB).create_content(movie)
      date_provider = DateProvider.new
      seen_date = Time.parse('2021-01-01')
      today = Time.parse('2021-01-02')
      date_provider.define_now_date(seen_date)
      client.sees_content(movie, date_provider, repository)
      date_provider.define_now_date(today)

      expect(client.seen_this_week(date_provider)).to include(movie)
    end

    it 'should not return movie seen 8 days ago when asking for content seen this week' do
      genre = Genre.new('Drama')
      movie_id = 0
      movie = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', Time.parse('2020-01-01'), 'Leonardo Di Caprio', 'Kate', movie_id)
      Persistence::Repositories::GenreRepo.new(DB).create_genre(genre)
      Persistence::Repositories::MovieRepo.new(DB).create_content(movie)
      date_provider = DateProvider.new
      seen_date = Time.parse('2021-01-01')
      today = Time.parse('2021-01-08')
      date_provider.define_now_date(seen_date)
      client.sees_content(movie, date_provider, repository)
      date_provider.define_now_date(today)

      expect(client.seen_this_week(date_provider)).not_to include(movie)
    end

    it 'should return movie seen 7 days ago when asking for content seen this week' do
      genre = Genre.new('Drama')
      movie_id = 0
      movie = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', Time.parse('2020-01-01'), 'Leonardo Di Caprio', 'Kate', movie_id)
      Persistence::Repositories::GenreRepo.new(DB).create_genre(genre)
      Persistence::Repositories::MovieRepo.new(DB).create_content(movie)
      seen_date = Time.parse('2021-01-02')
      today = Time.parse('2021-01-08')
      date_provider = DateProvider.new
      date_provider.define_now_date(seen_date)
      client.sees_content(movie, date_provider, repository)
      date_provider.define_now_date(today)

      expect(client.seen_this_week(date_provider)).to include(movie)
    end

    it 'should return last 3 contents seen this week when asking for content seen this week' do # rubocop:disable RSpec/ExampleLength
      genre = Genre.new('Drama')
      release_date = Time.parse('2020-01-01')
      movie1 = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', release_date, 'Leonardo Di Caprio', 'Kate', 0)
      movie2 = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', release_date, 'Leonardo Di Caprio', 'Kate', 1)
      movie3 = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', release_date, 'Leonardo Di Caprio', 'Kate', 2)
      movie4 = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', release_date, 'Leonardo Di Caprio', 'Kate', 3)
      Persistence::Repositories::GenreRepo.new(DB).create_genre(genre)
      Persistence::Repositories::MovieRepo.new(DB).create_content(movie1)
      Persistence::Repositories::MovieRepo.new(DB).create_content(movie2)
      Persistence::Repositories::MovieRepo.new(DB).create_content(movie3)
      Persistence::Repositories::MovieRepo.new(DB).create_content(movie4)
      seen_date1 = Time.parse('2021-01-02')
      date_provider = DateProvider.new
      date_provider.define_now_date(seen_date1)
      client.sees_content(movie1, date_provider, repository)
      seen_date2 = Time.parse('2021-01-03')
      date_provider.define_now_date(seen_date2)
      client.sees_content(movie2, date_provider, repository)
      seen_date3 = Time.parse('2021-01-04')
      date_provider.define_now_date(seen_date3)
      client.sees_content(movie3, date_provider, repository)
      seen_date4 = Time.parse('2021-01-05')
      date_provider.define_now_date(seen_date4)
      client.sees_content(movie4, date_provider, repository)

      expect(client.seen_this_week(date_provider)).not_to include(movie1)
    end

    it 'should not return liked content this week when asking for content seen this week' do
      genre = Genre.new('Drama')
      movie = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', Time.parse('2020-01-01'), 'Leonardo Di Caprio', 'Kate', 0)
      Persistence::Repositories::GenreRepo.new(DB).create_genre(genre)
      Persistence::Repositories::MovieRepo.new(DB).create_content(movie)
      date_provider = DateProvider.new
      seen_date = Time.parse('2021-01-05')
      today = Time.parse('2021-01-08')
      date_provider.define_now_date(seen_date)
      client.sees_content(movie, date_provider, repository)
      client.likes(movie, repository)
      date_provider.define_now_date(today)

      expect(client.seen_this_week(date_provider)).not_to include(movie)
    end

    it 'should return last 3 contents seen this week when asking for content seen this week added not in order' do # rubocop:disable RSpec/ExampleLength, Metrics/BlockLength
      genre = Genre.new('Drama')
      release_date = Time.parse('2020-01-01')
      movie1 = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', release_date, 'Leonardo Di Caprio', 'Kate', 0)
      movie2 = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', release_date, 'Leonardo Di Caprio', 'Kate', 1)
      movie3 = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', release_date, 'Leonardo Di Caprio', 'Kate', 2)
      movie4 = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', release_date, 'Leonardo Di Caprio', 'Kate', 3)
      Persistence::Repositories::GenreRepo.new(DB).create_genre(genre)
      Persistence::Repositories::MovieRepo.new(DB).create_content(movie1)
      Persistence::Repositories::MovieRepo.new(DB).create_content(movie2)
      Persistence::Repositories::MovieRepo.new(DB).create_content(movie3)
      Persistence::Repositories::MovieRepo.new(DB).create_content(movie4)
      date_provider = DateProvider.new
      seen_date1 = Time.parse('2021-01-02')
      seen_date2 = Time.parse('2021-01-03')
      seen_date3 = Time.parse('2021-01-04')
      seen_date4 = Time.parse('2021-01-05')
      date_provider.define_now_date(seen_date4)
      client.sees_content(movie1, date_provider, repository)
      date_provider.define_now_date(seen_date2)
      client.sees_content(movie2, date_provider, repository)
      date_provider.define_now_date(seen_date3)
      client.sees_content(movie3, date_provider, repository)
      date_provider.define_now_date(seen_date1)
      client.sees_content(movie4, date_provider, repository)
      date_provider.define_now_date(seen_date4)

      expect(client.seen_this_week(date_provider)).not_to include(movie4)
    end

    it 'should return last 3 contents seen this week not repeated when asking for content seen this week' do
      genre = Genre.new('Drama')
      movie = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', Time.parse('2020-01-01'), 'Leonardo Di Caprio', 'Kate', 0)
      Persistence::Repositories::GenreRepo.new(DB).create_genre(genre)
      Persistence::Repositories::MovieRepo.new(DB).create_content(movie)
      seen_date1 = Time.parse('2021-01-02')
      seen_date2 = Time.parse('2021-01-03')
      date_provider = DateProvider.new
      date_provider.define_now_date(seen_date1)
      client.sees_content(movie, date_provider, repository)
      date_provider.define_now_date(seen_date2)
      client.sees_content(movie, date_provider, repository)

      expect(client.seen_this_week(date_provider).size).to eq(1)
    end
  end

  describe 'add to list' do
    it 'should be able to mark movies as listed' do
      genre = Genre.new('Drama')
      movie_id = 0
      movie = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', Time.parse('2021-01-01'), 'Leonardo Di Caprio', 'Kate', movie_id)
      Persistence::Repositories::GenreRepo.new(DB).create_genre(genre)
      Persistence::Repositories::MovieRepo.new(DB).create_content(movie)
      client.lists(movie, repository)

      expect(client.contents_listed.size).to eq(1)
    end

    it 'should not be able to mark episodes as listed' do
      genre = Genre.new('Comedy')
      tv_show = TvShow.new('Titanic: La serie', 'ATP', 190, genre, 'USA', 'James Cameron', 'Leonardo Di Caprio', 'Kate')
      new_tv_show = Persistence::Repositories::TvShowRepo.new(DB).create_content(tv_show)
      episode = Episode.new(1, 1, Time.parse('2021-01-01'))
      episode.tv_show = new_tv_show
      created_episode = Persistence::Repositories::EpisodesRepo.new(DB).create_episode(episode)

      expect { client.lists(created_episode, repository) }.to raise_error(NotListableContentError)
    end

    it 'should not be able to mark content as listed when already listed' do
      genre = Genre.new('Drama')
      movie = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', Time.parse('2020-01-01'), 'Leonardo Di Caprio', 'Kate')
      Persistence::Repositories::GenreRepo.new(DB).create_genre(genre)
      Persistence::Repositories::MovieRepo.new(DB).create_content(movie)

      client.lists(movie, repository)

      saved_movie = Persistence::Repositories::ContentRepo.new(DB).find(movie.id)
      expect { client.lists(saved_movie, repository) }.to raise_error(ContentAlreadyListedError)
    end
  end
end
