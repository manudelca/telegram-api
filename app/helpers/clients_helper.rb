# Helper methods defined here can be accessed in any controller or view in the application

module WebTemplate
  class App
    module ClientsHelper
      def client_repo
        Persistence::Repositories::ClientRepo.new(DB)
      end

      def content_repo
        Persistence::Repositories::ContentRepo.new(DB)
      end

      def client_params
        @body ||= request.body.read
        JSON.parse(@body).symbolize_keys
      end

      def client_to_json(client)
        client_attributes(client).to_json
      end
    end

    helpers ClientsHelper
  end
end
