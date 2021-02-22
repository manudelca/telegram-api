require 'spec_helper'

describe Client do
  let(:client) { described_class.new('juan@test.com', 'juan') }

  it 'should be able to mark movies as seen' do
    genre = Genre.new('Drama')
    movie_id = 0
    movie = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', movie_id)
    client.sees_movie(movie, Time.now)

    expect(client.saw_movie?(movie)).to eq(true)
  end

  xit 'should seen episodes' do
    genre = Genre.new('Comedy')
    id = 0
    tv_show = TvShow.new('Titanic: La serie', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', id)
    season = Season.new(tv_show, 1, id)
    episode = Episode.new(season, 1, 0)
    client.sees_episode(episode)

    expect(client.saw_episode?(episode)).to eq(true)
  end

  xit 'should considered seen 1 episode and 1 movie' do
    genre = Genre.new('Comedy')
    id = 0
    tv_show = TvShow.new('Titanic: La serie', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', id)
    season = Season.new(tv_show, 1, id)
    episode = Episode.new(season, 1, 0)
    movie = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', id)
    client.sees_content(episode)
    client.sees_content(movie)

    expect(client.amount_content_seen).to eq(2)
    expect(client.saw_content?(episode)).to eq(true)
    expect(client.saw_content?(movie)).to eq(true)
  end

  it 'should be able to mark content as liked' do
    genre = Genre.new('Drama')
    movie_id = 0
    movie = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', movie_id)
    client.sees_movie(movie, Time.now)
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
    client.sees_movie(movie, seen_date)

    expect(client.seen_this_week(today)).to include(movie)
  end

  it 'should not return movie seen 8 days ago when asking for content seen this week' do
    genre = Genre.new('Drama')
    movie_id = 0
    movie = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', movie_id)
    seen_date = Time.parse('2021-01-01')
    today = Time.parse('2021-01-08')
    client.sees_movie(movie, seen_date)

    expect(client.seen_this_week(today)).not_to include(movie)
  end

  it 'should return movie seen 7 days ago when asking for content seen this week' do
    genre = Genre.new('Drama')
    movie_id = 0
    movie = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', movie_id)
    seen_date = Time.parse('2021-01-02')
    today = Time.parse('2021-01-08')
    client.sees_movie(movie, seen_date)

    expect(client.seen_this_week(today)).to include(movie)
  end
end
