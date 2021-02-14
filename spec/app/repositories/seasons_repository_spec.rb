require 'spec_helper'
require_relative '../../../app/persistence/repositories/tv_show_repo'

describe Persistence::Repositories::SeasonsRepo do # rubocop:disable RSpec/FilePath
  let(:repository) { described_class.new(DB) }

  describe 'changeset' do
    it 'changeset has number == season.number' do
      season = Season.new(1)
      expect(repository.send(:seasons_changeset, season)[:number]).to eq \
        season.number
    end
  end
end
