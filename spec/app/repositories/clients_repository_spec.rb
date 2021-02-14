require 'spec_helper'
# require_relative '../../../app/persistence/repositories/genre_repo'

describe Persistence::Repositories::ClientRepo do # rubocop:disable RSpec/FilePath
  let(:repository) { described_class.new(DB) }

  describe 'changeset' do
    it 'changeset has email == client.email' do
      client = Client.new(email: 'test@test.com')
      expect(repository.send(:client_changeset, client)[:email]).to eq \
        client.email
    end
  end
end
