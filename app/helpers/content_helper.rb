# Helper methods defined here can be accessed in any controller or view in the application
module WebTemplate
  class App
    module ContentHelper
      def movie_repo
        Persistence::Repositories::MovieRepo.new(DB)
      end

      def tv_show_repo
        Persistence::Repositories::TvShowRepo.new(DB)
      end

      def episodes_repo
        Persistence::Repositories::EpisodesRepo.new(DB)
      end

      def content_params
        @body ||= request.body.read
        JSON.parse(@body).symbolize_keys
      end
    end

    helpers ContentHelper
  end
end
