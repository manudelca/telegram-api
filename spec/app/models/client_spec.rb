require 'spec_helper'
require 'byebug'

describe Client do
  let(:client) { described_class.new('juan@test.com', 123) }
  let(:repository) { Persistence::Repositories::ClientRepo.new(DB) }

  it 'should be able to mark movies as seen' do
    genre = Genre.new('Drama')
    movie_id = 0
    movie = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', '2021-01-01', 'Leonardo Di Caprio', 'Kate', movie_id)
    Persistence::Repositories::GenreRepo.new(DB).create_genre(genre)
    Persistence::Repositories::MovieRepo.new(DB).create_content(movie)
    today = Time.parse('2021-01-02')
    client.sees_content(movie, today, repository)

    expect(client.saw_content?(movie)).to eq(true)
  end

  it 'should seen episodes' do
    genre = Genre.new('Comedy')
    id = 0
    tv_show = TvShow.new('Titanic: La serie', 'ATP', 190, genre, 'USA', 'James Cameron', 'Leonardo Di Caprio', 'Kate', id)
    new_tv_show = Persistence::Repositories::TvShowRepo.new(DB).create_content(tv_show)
    episode = Episode.new(1, 1, '2021-01-01')
    episode.tv_show = new_tv_show
    Persistence::Repositories::EpisodesRepo.new(DB).create_episode(episode)
    today = Time.parse('2021-01-02')
    client.sees_content(episode, today, repository)

    expect(client.saw_content?(episode)).to eq(true)
  end

  it 'should be able to mark content as liked' do
    genre = Genre.new('Drama')
    movie_id = 0
    movie = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', movie_id)
    Persistence::Repositories::GenreRepo.new(DB).create_genre(genre)
    Persistence::Repositories::MovieRepo.new(DB).create_content(movie)
    today = Time.parse('2021-01-02')
    client.sees_content(movie, today, repository)
    client.likes(movie, repository)

    expect(client.liked_content?(movie)).to eq(true)
  end

  it 'should raise exception if initialized with nil email' do
    email = nil
    telegram_user_id = 1
    expect { described_class.new(email, telegram_user_id) }.to raise_error(NoEmailError)
  end

  it 'should return movie seen yesterday when asking for content seen this week' do
    genre = Genre.new('Drama')
    movie_id = 0
    movie = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', movie_id)
    Persistence::Repositories::GenreRepo.new(DB).create_genre(genre)
    Persistence::Repositories::MovieRepo.new(DB).create_content(movie)
    seen_date = Time.parse('2021-01-01')
    today = Time.parse('2021-01-02')
    client.sees_content(movie, seen_date, repository)

    expect(client.seen_this_week(today)).to include(movie)
  end

  it 'should not return movie seen 8 days ago when asking for content seen this week' do
    genre = Genre.new('Drama')
    movie_id = 0
    movie = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', movie_id)
    Persistence::Repositories::GenreRepo.new(DB).create_genre(genre)
    Persistence::Repositories::MovieRepo.new(DB).create_content(movie)
    seen_date = Time.parse('2021-01-01')
    today = Time.parse('2021-01-08')
    client.sees_content(movie, seen_date, repository)

    expect(client.seen_this_week(today)).not_to include(movie)
  end

  it 'should return movie seen 7 days ago when asking for content seen this week' do
    genre = Genre.new('Drama')
    movie_id = 0
    movie = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', movie_id)
    Persistence::Repositories::GenreRepo.new(DB).create_genre(genre)
    Persistence::Repositories::MovieRepo.new(DB).create_content(movie)
    seen_date = Time.parse('2021-01-02')
    today = Time.parse('2021-01-08')
    client.sees_content(movie, seen_date, repository)

    expect(client.seen_this_week(today)).to include(movie)
  end

  it 'should return last 3 contents seen this week when asking for content seen this week' do
    genre = Genre.new('Drama')
    movie1 = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', 0)
    movie2 = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', 1)
    movie3 = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', 2)
    movie4 = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', 3)
    Persistence::Repositories::GenreRepo.new(DB).create_genre(genre)
    Persistence::Repositories::MovieRepo.new(DB).create_content(movie1)
    Persistence::Repositories::MovieRepo.new(DB).create_content(movie2)
    Persistence::Repositories::MovieRepo.new(DB).create_content(movie3)
    Persistence::Repositories::MovieRepo.new(DB).create_content(movie4)
    seen_date1 = Time.parse('2021-01-02')
    seen_date2 = Time.parse('2021-01-03')
    seen_date3 = Time.parse('2021-01-04')
    seen_date4 = Time.parse('2021-01-05')
    client.sees_content(movie1, seen_date1, repository)
    client.sees_content(movie2, seen_date2, repository)
    client.sees_content(movie3, seen_date3, repository)
    client.sees_content(movie4, seen_date4, repository)

    expect(client.seen_this_week(seen_date4)).not_to include(movie1)
  end

  it 'should not return liked content this week when asking for content seen this week' do
    genre = Genre.new('Drama')
    movie = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', 0)
    Persistence::Repositories::GenreRepo.new(DB).create_genre(genre)
    Persistence::Repositories::MovieRepo.new(DB).create_content(movie)
    seen_date = Time.parse('2021-01-05')
    today = Time.parse('2021-01-08')
    client.sees_content(movie, seen_date, repository)
    client.likes(movie, repository)

    expect(client.seen_this_week(today)).not_to include(movie)
  end

  it 'should raise error when seen a non-viewable content' do
    genre = Genre.new('Comedy')
    id = 0
    tv_show = TvShow.new('Titanic: La serie', 'ATP', 190, genre, 'USA', 'James Cameron', 'Leonardo Di Caprio', 'Kate', id)
    new_tv_show = Persistence::Repositories::TvShowRepo.new(DB).create_content(tv_show)
    seen_date = Time.parse('2021-01-05')

    expect { client.sees_content(new_tv_show, seen_date, repository) }.to raise_error(NotViewableContentError)
  end

  it 'should return last 3 contents seen this week when asking for content seen this week added not in order' do
    genre = Genre.new('Drama')
    movie1 = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', 0)
    movie2 = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', 1)
    movie3 = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', 2)
    movie4 = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', 3)
    Persistence::Repositories::GenreRepo.new(DB).create_genre(genre)
    Persistence::Repositories::MovieRepo.new(DB).create_content(movie1)
    Persistence::Repositories::MovieRepo.new(DB).create_content(movie2)
    Persistence::Repositories::MovieRepo.new(DB).create_content(movie3)
    Persistence::Repositories::MovieRepo.new(DB).create_content(movie4)
    seen_date1 = Time.parse('2021-01-02')
    seen_date2 = Time.parse('2021-01-03')
    seen_date3 = Time.parse('2021-01-04')
    seen_date4 = Time.parse('2021-01-05')
    client.sees_content(movie1, seen_date4, repository)
    client.sees_content(movie2, seen_date2, repository)
    client.sees_content(movie3, seen_date3, repository)
    client.sees_content(movie4, seen_date1, repository)

    expect(client.seen_this_week(seen_date4)).not_to include(movie4)
  end

  it 'should return last 3 contents seen this week not repeated when asking for content seen this week' do
    genre = Genre.new('Drama')
    movie = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', 0)
    Persistence::Repositories::GenreRepo.new(DB).create_genre(genre)
    Persistence::Repositories::MovieRepo.new(DB).create_content(movie)
    seen_date1 = Time.parse('2021-01-02')
    seen_date2 = Time.parse('2021-01-03')
    client.sees_content(movie, seen_date1, repository)
    client.sees_content(movie, seen_date2, repository)

    expect(client.seen_this_week(seen_date2).size).to eq(1)
  end

  it 'should be able to mark movies as listed' do
    genre = Genre.new('Drama')
    movie_id = 0
    movie = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', '2021-01-01', 'Leonardo Di Caprio', 'Kate', movie_id)
    Persistence::Repositories::GenreRepo.new(DB).create_genre(genre)
    Persistence::Repositories::MovieRepo.new(DB).create_content(movie)
    client.lists(movie, repository)

    expect(client.contents_listed.size).to eq(1)
  end

  it 'should not be able to mark episodes as listed' do
    genre = Genre.new('Comedy')
    tv_show = TvShow.new('Titanic: La serie', 'ATP', 190, genre, 'USA', 'James Cameron', 'Leonardo Di Caprio', 'Kate')
    new_tv_show = Persistence::Repositories::TvShowRepo.new(DB).create_content(tv_show)
    episode = Episode.new(1, 1, '2021-01-01')
    episode.tv_show = new_tv_show
    created_episode = Persistence::Repositories::EpisodesRepo.new(DB).create_episode(episode)

    expect { client.lists(created_episode, repository) }.to raise_error(NotListableContentError)
  end
end
