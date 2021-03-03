require 'spec_helper'
require_relative '../../../app/presentation/tv_show_output_parser'

describe TvShow do
  it 'tv_show can set episodes' do
    genre = Genre.new('comedy')
    tv_show_id = 1
    tv_show = described_class.new('The Office', 'No ATP', 190, genre,
                                  'USA', 'Ricky Gervais',
                                  'Steve Carrell', 'Rainn Wilson', tv_show_id)
    season_number = 1
    release_date = Time.parse('2021-01-01')
    episodes = []
    episodes << Episode.new(1, season_number, release_date, tv_show_id)
    tv_show.episodes = episodes
    expect(tv_show.number_of_seasons).to eq(1)
  end

  it 'tv_show number of seasons is 3' do
    genre = Genre.new('comedy')

    tv_show_id = 1
    tv_show = described_class.new('The Office', 'No ATP', 190, genre,
                                  'USA', 'Ricky Gervais',
                                  'Steve Carrell', 'Rainn Wilson', tv_show_id)
    season_number1 = 1
    season_number2 = 2
    season_number3 = 3
    release_date = Time.parse('2021-01-01')
    episodes = []
    episodes << Episode.new(1, season_number1, release_date, tv_show_id)
    episodes << Episode.new(1, season_number2, release_date, tv_show_id)
    episodes << Episode.new(1, season_number3, release_date, tv_show_id)
    tv_show.episodes = episodes
    expect(tv_show.number_of_seasons).to eq(3)
  end

  it 'tv_show number of episodes is sum of episodes' do
    genre = Genre.new('comedy')

    tv_show_id = 1
    tv_show = described_class.new('The Office', 'No ATP', 190, genre,
                                  'USA', 'Ricky Gervais',
                                  'Steve Carrell', 'Rainn Wilson', tv_show_id)
    season_number1 = 1
    season_number2 = 2
    season_number3 = 3
    release_date = Time.parse('2021-01-01')
    episodes = []
    episodes << Episode.new(1, season_number1, release_date, 1)
    episodes << Episode.new(1, season_number2, release_date, 2)
    episodes << Episode.new(1, season_number3, release_date, 3)
    tv_show.episodes = episodes

    expect(tv_show.number_of_episodes).to eq(3)
  end

  it 'tv_show is not viewable' do
    genre = Genre.new('comedy')
    tv_show_id = 1
    tv_show = described_class.new('The Office', 'No ATP', 190, genre,
                                  'USA', 'Ricky Gervais',
                                  'Steve Carrell', 'Rainn Wilson', tv_show_id)
    expect(tv_show.is_viewable).to eq(false)
  end

  it 'tv_show is listable' do
    genre = Genre.new('comedy')
    tv_show_id = 1
    tv_show = described_class.new('The Office', 'No ATP', 190, genre,
                                  'USA', 'Ricky Gervais',
                                  'Steve Carrell', 'Rainn Wilson', tv_show_id)
    expect(tv_show.is_listable).to eq(true)
  end

  it 'tv_show can be liked if it has 3 liked episodes' do # rubocop:disable RSpec/ExampleLength, Metrics/BlockLength
    client = Client.new('juan@test.com', 123)
    tv_show_id = 1
    tv_show = described_class.new('The Office', 'No ATP', 190, Genre.new('comedy'),
                                  'USA', 'Ricky Gervais',
                                  'Steve Carrell', 'Rainn Wilson', tv_show_id)
    season_number1 = 1
    season_number2 = 2
    season_number3 = 3
    release_date = Time.parse('2021-01-01')
    date_provider = DateProvider.new
    date_provider.define_now_date(release_date)
    episodes = []
    episodes << Episode.new(1, season_number1, release_date, 1)
    episodes << Episode.new(1, season_number2, release_date, 2)
    episodes << Episode.new(1, season_number3, release_date, 3)
    tv_show.episodes = episodes
    client_repository = instance_double('Persistence::Repositories::ClientRepo')
    allow(client_repository).to receive(:update_contents_seen).and_return(nil)
    allow(client_repository).to receive(:update_contents_liked).and_return(nil)
    client.sees_content(episodes[0], date_provider, client_repository)
    client.sees_content(episodes[1], date_provider, client_repository)
    client.sees_content(episodes[2], date_provider, client_repository)
    client.likes(episodes[0], client_repository)
    client.likes(episodes[1], client_repository)
    client.likes(episodes[2], client_repository)
    tv_show.be_liked_by(client)

    expect(client.liked_content?(tv_show)).to eq(true)
  end

  it 'tv_show can\' be liked if it has 2 liked episodes' do # rubocop:disable RSpec/ExampleLength
    client = Client.new('juan@test.com', 123)
    tv_show_id = 1
    tv_show = described_class.new('The Office', 'No ATP', 190, Genre.new('comedy'),
                                  'USA', 'Ricky Gervais',
                                  'Steve Carrell', 'Rainn Wilson', tv_show_id)
    season_number1 = 1
    season_number2 = 2
    release_date = Time.parse('2021-01-01')
    date_provider = DateProvider.new
    date_provider.define_now_date(release_date)
    episodes = []
    episodes << Episode.new(1, season_number1, release_date, 1)
    episodes << Episode.new(1, season_number2, release_date, 2)
    tv_show.episodes = episodes
    client_repository = instance_double('Persistence::Repositories::ClientRepo')
    allow(client_repository).to receive(:update_contents_seen).and_return(nil)
    allow(client_repository).to receive(:update_contents_liked).and_return(nil)
    client.sees_content(episodes[0], date_provider, client_repository)
    client.sees_content(episodes[1], date_provider, client_repository)
    client.likes(episodes[0], client_repository)
    client.likes(episodes[1], client_repository)

    expect { tv_show.be_liked_by(client) }.to raise_error(NotEnoughEpisodesLikedError)
  end
end
