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
    episodes << Episode.new(1, season_number1, release_date, tv_show_id)
    episodes << Episode.new(1, season_number2, release_date, tv_show_id)
    episodes << Episode.new(1, season_number3, release_date, tv_show_id)
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
end
