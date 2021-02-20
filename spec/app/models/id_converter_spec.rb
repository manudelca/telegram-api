require 'spec_helper'

describe IdConverter do
  let(:converter) { described_class.new }

  it 'should return movie repo when last 2 digits are 00' do
    id = 12_300
    repo = converter.get_repo(id)
    expect(repo).to be_instance_of(Persistence::Repositories::MovieRepo)
  end

  it 'should return tv show repo when last 2 digits are 01' do
    id = 112_301
    repo = converter.get_repo(id)
    expect(repo).to be_instance_of(Persistence::Repositories::TvShowRepo)
  end

  it 'should return episode repo when last 2 digits are 02' do
    id = 212_302
    repo = converter.get_repo(id)
    expect(repo).to be_instance_of(Persistence::Repositories::EpisodesRepo)
  end

  it 'should parse id removing last 2 digits' do
    id = 12_300
    expect(converter.parse_id(id)).to eq(123)
  end

  xit 'should add 00 to movie created' do
    id = 1123
    expect(converter.parse_movie_id(id)).to eq(112_300)
  end

  xit 'should add 01 to tv show created' do
    id = 1123
    expect(converter.parse_movie_id(id)).to eq(112_301)
  end

  xit 'should add 02 to episode created' do
    id = 1123
    expect(converter.parse_movie_id(id)).to eq(112_302)
  end
end
