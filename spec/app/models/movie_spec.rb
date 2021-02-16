require 'spec_helper'

describe Movie do
  it 'should be able to be considered the same by their id' do
    genre = Genre.new('Drama')
    movie_id = 0
    movie = described_class.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', movie_id)
    same_movie = described_class.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', movie_id)

    expect(movie.eql?(same_movie)).to eq(true)
  end
end
