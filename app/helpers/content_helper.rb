# Helper methods defined here can be accessed in any controller or view in the application

module WebTemplate
  class App
    module ContentHelper
      def content_params
        @body ||= request.body.read
        JSON.parse(@body).symbolize_keys
      end

      def movie_to_json
        {}
      end
    end

    helpers ContentHelper
  end
end
