require 'spec_helper'

describe Episode do
  let(:genre) { Genre.new('Drama') }
  let(:episode) { described_class.new(1, 1, Time.parse('2020-01-01'), 1) }

  it 'cant be created if release date is nil' do
    expect { described_class.new(1, 1, nil, 1) }.to raise_error(MissingReleaseDateError)
  end

  it 'cant be created without a season number' do
    expect { described_class.new(1, nil, Time.parse('2020-01-01'), 1) }.to raise_error(MissingSeasonNumberError)
  end

  it 'cant be created without a episode number' do
    expect { described_class.new(nil, 1, Time.parse('2020-01-01'), 1) }.to raise_error(MissingEpisodeNumberError)
  end

  it 'episode is viewable' do
    expect(episode.is_viewable).to eq(true)
  end

  it 'episode is not listable' do
    expect(episode.is_listable).to eq(false)
  end

  it 'episode can be liked if it was seen by the client' do
    client = Client.new('juan@test.com', 123)
    today = Time.parse('2021-01-02')
    date_provider = DateProvider.new
    date_provider.define_now_date(today)
    client_repository = instance_double('Persistence::Repositories::ClientRepo')
    allow(client_repository).to receive(:update_contents_seen).and_return(nil)
    client.sees_content(episode, date_provider, client_repository)
    episode.be_liked_by(client)

    expect(client.liked_content?(episode)).to eq(true)
  end

  it 'episode should raise error if liked and not seen by the client' do
    client = Client.new('juan@test.com', 123)

    expect { episode.be_liked_by(client) }.to raise_error(ContentNotSeenError)
  end

  it 'episode tells if it was released' do
    expect(episode.was_released?(Time.parse('2021-01-01'))).to eq(true)
  end
end
