require 'rom/transformer'

module Persistence
  module Mappers
    class ClientMapper
      def call(clients)
        clients.map do |client|
          build_client_from(client)
        end
      end

      def build_client_from(client_attributes)
        Client.new(client_attributes.email, client_attributes.id)
      end
    end
  end
end
