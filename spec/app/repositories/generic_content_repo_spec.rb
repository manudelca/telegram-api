require 'spec_helper'

describe Persistence::Repositories::GenericContentRepo do # rubocop:disable RSpec/FilePath
  let(:repository) { described_class.new(DB) }

  before(:each) do
    genre_repository = Persistence::Repositories::GenreRepo.new(DB)
    new_genre = Genre.new('drama')
    @genre = genre_repository.create_genre(new_genre)
  end

  after(:each) do
    described_class.new(DB).delete_all
    Persistence::Repositories::GenreRepo.new(DB).delete_all
  end

  describe 'find by descendant release date' do
    it 'no content raise ContentNotFound' do
      expect { repository.find_by_desc_release_date(3) }.to raise_error(ContentNotFound)
    end
  end
end
