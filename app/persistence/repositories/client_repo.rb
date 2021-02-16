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

      def find_by_email(email)
        clients_relation = clients.where(email: email)
        clients_relation = (clients_relation >> client_mapper)
        clients_relation.first
      end

      private

      def client_changeset(client)
        {email: client.email, username: client.username}
      end

      def client_mapper
        Persistence::Mappers::ClientMapper.new
      end
    end
  end
end
