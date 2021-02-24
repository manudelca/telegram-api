require 'spec_helper'

describe Content do
  let(:content) { described_class.new(1) }

  it 'content is viewable should raise error' do
    expect { content.is_viewable }.to raise_error(ShoulBeImplementedInDerivedClassesError)
  end

  it 'content is likeable should raise error' do
    expect { content.is_likeable }.to raise_error(ShoulBeImplementedInDerivedClassesError)
  end
end
