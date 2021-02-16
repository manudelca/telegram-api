require 'spec_helper'

describe Client do
  let(:client) { described_class.new('juan@test.com', 'juan') }

  it 'should be able to mark movies as seen' do
    genre = Genre.new('Drama')
    movie_id = 0
    movie = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', movie_id)
    client.sees_content(movie)

    expect(client.saw_content?(movie)).to eq(true)
  end
end
