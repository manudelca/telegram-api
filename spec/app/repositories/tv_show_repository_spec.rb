require 'spec_helper'
require_relative '../../../app/persistence/repositories/tv_show_repo'

describe Persistence::Repositories::TvShowRepo do # rubocop:disable RSpec/FilePath
  let(:repository) { described_class.new(DB) }

  describe 'changeset' do
    it 'changeset has name == movie.name' do
      tv_show = TvShow.new(name: 'Titanic')
      expect(repository.send(:tv_show_changeset, tv_show)[:name]).to eq \
        tv_show.name
    end
  end

  describe 'save tv show' do
    it 'must save tv show' do
      tv_show = TvShow.new('The Office')
      saved_tv_show = repository.create_tv_show(tv_show)
      expect(repository.find(saved_tv_show.id).name).to eq tv_show.name
    end
  end
end
