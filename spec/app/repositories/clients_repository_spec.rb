require 'spec_helper'
# require_relative '../../../app/persistence/repositories/genre_repo'

describe Persistence::Repositories::ClientRepo do # rubocop:disable RSpec/FilePath
  let(:repository) { described_class.new(DB) }

  describe 'changeset' do
    it 'changeset has email == client.email' do
      client = Client.new('test@test.com', 'test78')
      expect(repository.send(:client_changeset, client)[:email]).to eq \
        client.email
    end

    it 'changeset has username == client.username' do
      client = Client.new('test@test.com', 'test78')
      expect(repository.send(:client_changeset, client)[:username]).to eq \
        client.username
    end
  end

  describe 'save client' do
    it 'must save client' do
      client = Client.new('test@test.com', 'test78')
      saved_client = repository.create_client(client)
      expect(repository.find(saved_client.id).email).to eq client.email
    end
  end
end
