module Persistence
  module Repositories
    class ClientRepo < ROM::Repository[:clients]
      commands :create

      def client_changeset(client)
        {email: client.email}
      end
    end
  end
end
