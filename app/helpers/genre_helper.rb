# Helper methods defined here can be accessed in any controller or view in the application

module WebTemplate
  class App
    module GenreHelper
      def genre_repo
        Persistence::Repositories::GenreRepo.new(DB)
      end

      def genre_params
        @body ||= request.body.read
        JSON.parse(@body).symbolize_keys
      end

      def genre_to_json(genre); end
    end

    helpers GenreHelper
  end
end
