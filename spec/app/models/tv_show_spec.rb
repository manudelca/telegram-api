require 'spec_helper'

describe TvShow do
  it 'rv_show number of seasons is 3' do
    genre = Genre.new('comedy')

    tv_show_id = 1
    seasons = []
    seasons << Season.new(1, tv_show_id)
    seasons << Season.new(2, tv_show_id)
    seasons << Season.new(3, tv_show_id)
    tv_show = described_class.new('The Office', 'No ATP', 190, genre,
                                  'USA', 'Ricky Gervais', '2021-01-01',
                                  'Steve Carrell', 'Rainn Wilson', tv_show_id,
                                  seasons)

    expect(tv_show.number_of_seasons).to eq(3)
  end
end
