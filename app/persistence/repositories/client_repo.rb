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
        clients_relation = (clients.combine(liked: :genres)
                                   .combine(seen: :genres)
                                   .combine(:contents_seen_date)
                                   .combine(listed: :genres)
                                   .by_pk(id) >> client_mapper)
        client = clients_relation.one
        raise ClientNotFound if client.nil?

        client
      end

      def find_by_telegram_user_id(telegram_user_id)
        clients_relation = clients.where(telegram_user_id: telegram_user_id)
                                  .combine(liked: :genres)
                                  .combine(seen: :genres)
                                  .combine(:contents_seen_date)
                                  .combine(listed: :genres)
        clients_relation = (clients_relation >> client_mapper)
        client = clients_relation.first
        raise ClientNotFound if client.nil?

        client
      end

      def find_by_email(email)
        clients_relation = clients.where(email: email)
                                  .combine(liked: :genres)
                                  .combine(seen: :genres)
                                  .combine(:contents_seen_date)
                                  .combine(listed: :genres)
        clients_relation = (clients_relation >> client_mapper)

        clients_relation.first
      end

      def update_contents_seen(client)
        clients_contents_relation.where(client_id: client.id).delete
        client.contents_seen.each do |view|
          clients_contents_create_command.call(clients_contents_changeset(view))
        end
      end

      def update_contents_liked(client)
        clients_contents_liked_relation.where(client_id: client.id).delete
        client.contents_liked.each do |content|
          clients_contents_liked_create_command.call(clients_contents_liked_changeset(client, content))
        end
      end

      def update_contents_listed(client)
        clients_contents_listed_relation.where(client_id: client.id).delete
        client.contents_listed.each do |content|
          clients_contents_listed_create_command.call(clients_contents_listed_changeset(client, content))
        end
      end

      def delete_all
        clients_contents_relation.delete
        clients_contents_liked_relation.delete
        clients_contents_listed_relation.delete
        clients.delete
      end

      private

      def clients_contents_create_command
        clients_contents_relation.command(:create)
      end

      def clients_contents_relation
        container.relations[:clients_contents]
      end

      def clients_contents_liked_create_command
        clients_contents_liked_relation.command(:create)
      end

      def clients_contents_liked_relation
        container.relations[:clients_contents_liked]
      end

      def clients_contents_listed_create_command
        clients_contents_listed_relation.command(:create)
      end

      def clients_contents_listed_relation
        container.relations[:clients_contents_listed]
      end

      def client_changeset(client)
        {email: client.email, telegram_user_id: client.telegram_user_id}
      end

      def clients_contents_changeset(view)
        {client_id: view.client.id, content_id: view.content.id, date: view.date}
      end

      def clients_contents_liked_changeset(client, content)
        {client_id: client.id, content_id: content.id}
      end

      def clients_contents_listed_changeset(client, content)
        {client_id: client.id, content_id: content.id}
      end

      def client_mapper
        Persistence::Mappers::ClientMapper.new
      end
    end
  end
end
