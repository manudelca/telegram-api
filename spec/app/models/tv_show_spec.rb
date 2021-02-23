require 'spec_helper'

describe TvShow do
  it 'tv_show number of seasons is 3' do
    genre = Genre.new('comedy')

    tv_show_id = 1
    seasons = []
    seasons << Season.new(1, tv_show_id, '2021-01-01')
    seasons << Season.new(2, tv_show_id, '2021-01-01')
    seasons << Season.new(3, tv_show_id, '2021-01-01')
    tv_show = described_class.new('The Office', 'No ATP', 190, genre,
                                  'USA', 'Ricky Gervais', '2021-01-01',
                                  'Steve Carrell', 'Rainn Wilson', tv_show_id,
                                  seasons)

    expect(tv_show.number_of_seasons).to eq(3)
  end

  it 'tv_show number of episodes is sum of episodes of the seasons' do
    genre = Genre.new('comedy')

    tv_show_id = 1
    seasons = []
    seasons << Season.new(1, tv_show_id, '2021-01-01')
    seasons << Season.new(2, tv_show_id, '2021-01-01')
    seasons << Season.new(3, tv_show_id, '2021-01-01')
    tv_show = described_class.new('The Office', 'No ATP', 190, genre,
                                  'USA', 'Ricky Gervais', '2021-01-01',
                                  'Steve Carrell', 'Rainn Wilson', tv_show_id,
                                  seasons)

    allow_any_instance_of(Season).to receive(:number_of_episodes).and_return(3)
    expect(tv_show.number_of_episodes).to eq(9)
  end

  it 'tv_show get last season ' do
    genre = Genre.new('comedy')

    tv_show_id = 1
    seasons = []
    seasons << Season.new(1, tv_show_id, '2021-01-01')
    seasons << Season.new(2, tv_show_id, '2021-01-02')
    seasons << Season.new(3, tv_show_id, '2021-01-03')
    tv_show = described_class.new('The Office', 'No ATP', 190, genre,
                                  'USA', 'Ricky Gervais', '2021-01-03',
                                  'Steve Carrell', 'Rainn Wilson', tv_show_id,
                                  seasons)

    expect(tv_show.last_season.number).to eq(3)
  end

  it 'tv_show is not viewable' do
    genre = Genre.new('comedy')
    tv_show_id = 1
    seasons = []
    tv_show = described_class.new('The Office', 'No ATP', 190, genre,
                                  'USA', 'Ricky Gervais', '2021-01-01',
                                  'Steve Carrell', 'Rainn Wilson', tv_show_id,
                                  seasons)
    expect(tv_show.is_viewable).to eq(false)
  end
end
