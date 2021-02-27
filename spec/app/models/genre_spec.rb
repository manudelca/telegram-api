require 'spec_helper'

describe Genre do
  it 'genre must have name' do
    expect { described_class.new(nil) }.to raise_error(NoNameError)
  end
end
