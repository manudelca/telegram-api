require 'spec_helper'
require 'byebug'

describe Client do
  let(:client) { described_class.new('juan@test.com', 'juan') }

  it 'should be able to mark movies as seen' do
    genre = Genre.new('Drama')
    movie_id = 0
    movie = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', movie_id)
    client.sees_content(movie, Time.now)

    expect(client.saw_content?(movie)).to eq(true)
  end

  it 'should seen episodes' do
    genre = Genre.new('Comedy')
    id = 0
    tv_show = TvShow.new('Titanic: La serie', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', id)
    season = Season.new(tv_show, 1, id)
    episode = Episode.new(season, 1, 0)
    today = Time.parse('2021-01-02')
    client.sees_content(episode, today)

    expect(client.saw_content?(episode)).to eq(true)
  end

  it 'should be able to mark content as liked' do
    genre = Genre.new('Drama')
    movie_id = 0
    movie = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', movie_id)
    today = Time.parse('2021-01-02')
    client.sees_content(movie, today)
    client.likes(movie)

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
    seen_date = Time.parse('2021-01-01')
    today = Time.parse('2021-01-02')
    client.sees_content(movie, seen_date)

    expect(client.seen_this_week(today)).to include(movie)
  end

  it 'should not return movie seen 8 days ago when asking for content seen this week' do
    genre = Genre.new('Drama')
    movie_id = 0
    movie = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', movie_id)
    seen_date = Time.parse('2021-01-01')
    today = Time.parse('2021-01-08')
    client.sees_content(movie, seen_date)

    expect(client.seen_this_week(today)).not_to include(movie)
  end

  it 'should return movie seen 7 days ago when asking for content seen this week' do
    genre = Genre.new('Drama')
    movie_id = 0
    movie = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', movie_id)
    seen_date = Time.parse('2021-01-02')
    today = Time.parse('2021-01-08')
    client.sees_content(movie, seen_date)

    expect(client.seen_this_week(today)).to include(movie)
  end

  it 'should return last 3 contents seen this week when asking for content seen this week' do
    genre = Genre.new('Drama')
    movie1 = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', 0)
    movie2 = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', 1)
    tv_show = TvShow.new('Titanic: La serie', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', 0)
    season = Season.new(tv_show, 1, 0)
    episode1 = Episode.new(season, 1, 0)
    episode2 = Episode.new(season, 2, 0)
    seen_date1 = Time.parse('2021-01-02')
    seen_date2 = Time.parse('2021-01-03')
    seen_date3 = Time.parse('2021-01-04')
    seen_date4 = Time.parse('2021-01-05')
    today = Time.parse('2021-01-08')
    client.sees_content(movie1, seen_date1)
    client.sees_content(movie2, seen_date2)
    client.sees_content(episode1, seen_date3)
    client.sees_content(episode2, seen_date4)

    expect(client.seen_this_week(today)).not_to include(movie1)
  end

  it 'should not return liked content this week when asking for content seen this week' do
    genre = Genre.new('Drama')
    movie = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', 0)
    seen_date = Time.parse('2021-01-05')
    today = Time.parse('2021-01-08')
    client.sees_content(movie, seen_date)
    client.likes(movie)

    expect(client.seen_this_week(today)).not_to include(movie)
  end

  it 'should like movie' do
    genre = Genre.new('Drama')
    movie = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', 0)
    seen_date = Time.parse('2021-01-05')
    client.sees_content(movie, seen_date)
    client.likes_movie(movie)

    expect(client.movies_liked).to include(movie)
  end
end
