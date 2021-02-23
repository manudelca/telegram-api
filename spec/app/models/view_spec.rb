require 'spec_helper'

describe View do
  it 'view successful creation' do
    client = Client.new('juan@test.com', 'juan')
    genre = Genre.new('Drama')
    movie_id = 0
    content = Movie.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', movie_id)
    date = Time.parse('2021-01-02')
    view = described_class.new(client, content, date)
    expect(view.client).to eq(client)
    expect(view.content).to eq(content)
    expect(view.date).to eq(date)
  end
end
