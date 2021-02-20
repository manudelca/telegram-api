require 'spec_helper'

describe IdConverter do
  let(:converter) { described_class.new }

  it 'should return movie repo when first 2 digits are 00' do
    id = '00123'
    repo = converter.get_repo(id)
    expect(repo).to be_instance_of(Persistence::Repositories::MovieRepo)
  end

  it 'should return tv show repo when first 2 digits are 01' do
    id = '01123'
    repo = converter.get_repo(id)
    expect(repo).to be_instance_of(Persistence::Repositories::TvShowRepo)
  end

  xit 'should return episode repo when first 2 digits are 02' do
    id = '02123'
    repo = converter.get_repo(id)
    expect(repo).to be_instance_of(EpisodesRepo)
  end

  xit 'should parse id removing first 2 digits' do
    id = '00123'
    expect(converter.parse_id(id)).to eq(123)
  end

  xit 'should add 00 to movie created' do
    id = '1123'
    expect(converter.parse_movie_id(id)).to eq(0o01123)
  end

  xit 'should add 01 to tv show created' do
    id = '1123'
    expect(converter.parse_movie_id(id)).to eq(0o11123)
  end

  xit 'should add 02 to episode created' do
    id = '1123'
    expect(converter.parse_movie_id(id)).to eq(0o21123)
  end
end
