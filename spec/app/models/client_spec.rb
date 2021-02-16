require 'spec_helper'
require 'byebug'

describe Client do
  let(:client) { described_class.new('juan@test.com', 'juan') }

  it 'should be able to mark movies as seen' do
    genre = Genre.new('Drama')
    movie_id = 0
    movie = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', movie_id)
    client.sees_content(movie)

    expect(client.saw_content?(movie)).to eq(true)
  end

  it 'should considered seen 2 different objects but same movie' do
    genre = Genre.new('Drama')
    movie_id = 0
    movie = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', movie_id)
    same_movie = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', movie_id)
    client.sees_content(movie)

    expect(client.saw_content?(same_movie)).to eq(true)
  end

  it 'should considered seen episodes' do
    genre = Genre.new('Comedy')
    id = 0
    tv_show = TvShow.new('Titanic: La serie', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', id)
    season = Season.new(tv_show, 1, id)
    episode = Episode.new(season, 1, 0)
    client.sees_content(episode)

    expect(client.saw_content?(episode)).to eq(true)
  end

  it 'should considered seen episodes 2 different objects but same episode' do
    genre = Genre.new('Comedy')
    id = 0
    tv_show = TvShow.new('Titanic: La serie', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', id)
    season = Season.new(tv_show, 1, id)
    episode = Episode.new(season, 1, 0)
    same_episode = Episode.new(season, 1, 0)
    client.sees_content(episode)

    expect(client.saw_content?(same_episode)).to eq(true)
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

    expect(client.saw_content?(episode)).to eq(true)
    expect(client.saw_content?(movie)).to eq(true)
  end
end
