require 'rom/transformer'

module Persistence
  module Mappers
    class ClientMapper
      def call(clients)
        clients.map do |client_attributes|
          build_client_from(client_attributes)
        end
      end

      def movie_mapper
        MovieMapper.new
      end

      def genre_mapper
        GenreMapper.new
      end

      def build_client_from(client_attributes)
        client = Client.new(client_attributes.email, client_attributes.username, client_attributes.id)
        client_attributes.seen.each do |content|
          next unless content.type == 'movie'

          genre = genre_mapper.build_genre_from(content.genres)
          client.sees_movie(movie_mapper.build_movie_from(content, genre))
        end
        client
      end
    end
  end
end
