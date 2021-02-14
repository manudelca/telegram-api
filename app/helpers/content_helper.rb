# Helper methods defined here can be accessed in any controller or view in the application

module WebTemplate
  class App
    module ContentHelper
      def content_repo(content_type)
        dic_content_repo = {
          'movie' => Persistence::Repositories::MovieRepo,
          'tv_show' => Persistence::Repositories::TvShowRepo
        }
        clazz = dic_content_repo[content_type]
        clazz.new(DB)
      end

      def movie_repo
        Persistence::Repositories::MovieRepo.new(DB)
      end

      def tv_show_repo
        Persistence::Repositories::TvShowRepo.new(DB)
      end

      def content_params
        @body ||= request.body.read
        JSON.parse(@body).symbolize_keys
      end

      def content_to_json(content_type, content)
        dic_content_repo = {
          'movie' => method(:movie_to_json),
          'tv_show' => method(:tv_show_to_json)
        }
        dic_content_repo[content_type][content]
      end

      private

      def movie_to_json(_movie)
        {}
      end

      def tv_show_to_json(_tv_show)
        {}
      end
    end

    helpers ContentHelper
  end
end
