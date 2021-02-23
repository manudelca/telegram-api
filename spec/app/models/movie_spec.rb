require 'spec_helper'
require_relative '../../../app/presentation/movie_output_parser'

describe Movie do
  let(:genre) { Genre.new('Drama') }
  let(:movie) { described_class.new('Titanic', 'ATP', 190, genre, 'USA', 'James Cameron', '2020-01-01', 'Leonardo Di Caprio', 'Kate', 1) }

  it 'movie is viewable' do
    expect(movie.is_viewable).to eq(true)
  end
end
