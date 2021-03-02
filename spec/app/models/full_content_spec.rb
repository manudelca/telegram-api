require 'spec_helper'

describe FullContent do
  it 'genre nil should raise error' do
    expect { described_class.new(nil, 0) }.to raise_error(GenreNotFound)
  end
end
