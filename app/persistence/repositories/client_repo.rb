module Persistence
  module Repositories
    class ClientRepo < ROM::Repository[:clients]
      commands :create

      def create_client(client)
        client_struct = create(client_changeset(client))
        client.id = client_struct.id

        client
      end

      def find(id)
        clients_relation = (clients.by_pk(id) >> client_mapper)
        clients_relation.one
      end

      private

      def client_changeset(client)
        {email: client.email}
      end

      def client_mapper
        Persistence::Mappers::ClientMapper.new
      end
    end
  end
end
