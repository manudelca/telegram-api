require 'spec_helper'
require_relative '../../../app/presentation/movie_output_parser'

describe Movie do
  let(:genre) { Genre.new('Drama') }
  let(:movie) { described_class.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', Time.parse('2020-01-01'), 'Leonardo Di Caprio', 'Kate', 1) }

  it 'movie is viewable' do
    expect(movie.is_viewable).to eq(true)
  end

  it 'movie is listable' do
    expect(movie.is_listable).to eq(true)
  end

  it 'movie can be liked if it was seen by the client' do
    client = Client.new('juan@test.com', 123)
    today = Time.parse('2021-01-02')
    client_repository = instance_double('Persistence::Repositories::ClientRepo')
    allow(client_repository).to receive(:update_contents_seen).and_return(nil)
    client.sees_content(movie, today, client_repository)
    movie.be_liked_by(client)

    expect(client.liked_content?(movie)).to eq(true)
  end

  it 'movie should raise error if liked and not seen by the client' do
    client = Client.new('juan@test.com', 123)

    expect { movie.be_liked_by(client) }.to raise_error(ContentNotSeenError)
  end

  it 'movie tells if it was released' do
    expect(movie.was_released?(Time.parse('2021-01-01'))).to eq(true)
  end
end
