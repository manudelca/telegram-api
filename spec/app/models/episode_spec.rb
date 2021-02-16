require 'spec_helper'

describe Episode do
  it 'should be able to be considered the same by their id' do
    genre = Genre.new('Comedy')
    id = 0
    tv_show = TvShow.new('Titanic: La serie', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', id)
    season = Season.new(tv_show, 1, id)
    episode = described_class.new(season, 1, 0)
    same_episode = described_class.new(season, 1, 0)

    expect(episode.eql?(same_episode)).to eq(true)
  end
end
