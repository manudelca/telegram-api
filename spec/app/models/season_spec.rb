require 'spec_helper'

describe Season do
  it 'season number of episodes is 3' do
    tv_show_id = 1
    season_one = 1
    season_one_episodes = []
    season_one_episodes << Episode.new(1, tv_show_id)
    season_one_episodes << Episode.new(2, tv_show_id)
    season_one_episodes << Episode.new(3, tv_show_id)
    tv_show = described_class.new(season_one, tv_show_id, 1, season_one_episodes)

    expect(tv_show.number_of_episodes).to eq(3)
  end
end
