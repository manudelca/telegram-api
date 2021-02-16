require 'spec_helper'

describe Movie do
  it 'should be able to be considered the same by their id' do
    genre = Genre.new('Drama')
    movie_id = 0
    movie = described_class.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', movie_id)
    same_movie = described_class.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', movie_id)

    expect(movie.eql?(same_movie)).to eq(true)
  end

  it 'should not be equal to a episode with same id' do
    genre = Genre.new('Comedy')
    id = 0
    tv_show = TvShow.new('Titanic: La serie', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', id)
    season = Season.new(tv_show, 1, id)
    episode = Episode.new(season, 1, id)
    movie = described_class.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', id)

    expect(movie.eql?(episode)).to eq(false)
  end
end
