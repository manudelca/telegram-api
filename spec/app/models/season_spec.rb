require 'spec_helper'

describe Season do
  it 'season number of episodes is 3' do
    tv_show_id = 1
    season_id = 1
    season_one = 1
    season_one_episodes = []
    season_one_episodes << Episode.new(1, season_id)
    season_one_episodes << Episode.new(2, season_id)
    season_one_episodes << Episode.new(3, season_id)
    season = described_class.new(season_one, tv_show_id, '2021-01-01',
                                 season_id, season_one_episodes)

    expect(season.number_of_episodes).to eq(3)
  end

  it 'season is not viewable' do
    tv_show_id = 1
    season_id = 1
    season_one = 1
    season_one_episodes = []
    season = described_class.new(season_one, tv_show_id, '2021-01-01',
                                 season_id, season_one_episodes)
    expect(season.is_viewable).to eq(false)
  end

  it 'season update release date' do
    tv_show_id = 1
    season_id = 1
    season_one = 1
    season_one_episodes = []
    season_one_episodes << Episode.new(1, season_id)
    season_one_episodes << Episode.new(2, season_id)
    season_one_episodes << Episode.new(3, season_id)
    season = described_class.new(season_one, tv_show_id, '2021-01-01',
                                 season_id, season_one_episodes)

    season.update_release_date('2022-01-01')
    expect(season.release_date).to eq('2022-01-01')
  end
end
