require 'spec_helper'

describe Persistence::Repositories::SeasonsRepo do # rubocop:disable RSpec/FilePath
  let(:repository) { described_class.new(DB) }

  let(:tv_show) do
    tv_show = TvShow.new('Titanic')
    Persistence::Repositories::TvShowRepo.new(DB).create_content(tv_show)
  end

  describe 'changeset' do
    it 'changeset has number == season.number' do
      season = Season.new(tv_show, 1)
      expect(repository.send(:seasons_changeset, season)[:number]).to eq \
        season.number
    end

    it 'changeset has tv_show_id == tv_show.id' do
      season = Season.new(tv_show, 1)
      expect(repository.send(:seasons_changeset, season)[:tv_show_id]).to eq \
        tv_show.id
    end
  end

  describe 'save seasons' do
    it 'must save season' do
      season = Season.new(tv_show, 1)
      saved_season = repository.create_season(season)
      expect(repository.find(saved_season.id).number).to eq season.number
    end
  end
end
