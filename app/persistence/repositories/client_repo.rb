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
        clients_relation = (clients.combine(contents: :genres).by_pk(id) >> client_mapper)
        clients_relation.one
      end

      def find_by_email(email)
        clients_relation = clients.where(email: email).combine(contents: :genres)
        clients_relation = (clients_relation >> client_mapper)
        clients_relation.first
      end

      def update_movies_seen(client)
        clients_contents_relation.where(client_id: client.id).delete
        client.movies_seen.each do |movie|
          clients_contents_create_command.call(clients_contents_changeset(client, movie))
        end
      end

      private

      def clients_contents_create_command
        clients_contents_relation.command(:create)
      end

      def clients_contents_relation
        container.relations[:clients_contents]
      end

      def client_changeset(client)
        {email: client.email, username: client.username}
      end

      def clients_contents_changeset(client, content)
        {client_id: client.id, content_id: content.id}
      end

      def client_mapper
        Persistence::Mappers::ClientMapper.new
      end
    end
  end
end
