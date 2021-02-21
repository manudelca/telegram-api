require 'rom/transformer'
require 'byebug'

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

      def build_client_from(client_attributes) # rubocop:disable Metrics/AbcSize
        client = Client.new(client_attributes.email, client_attributes.telegram_user_id, client_attributes.id)
        dates = {}
        client_attributes.seen_date.each do |seen_date|
          if dates.key?(seen_date.content_id)
            dates[seen_date.content_id].append(seen_date.date)
          else
            dates[seen_date.content_id] = [seen_date.date]
          end
        end
        client_attributes.seen.each do |content|
          next unless content.type == 'movie'

          genre = genre_mapper.build_genre_from(content.genres)
          client.sees_movie(movie_mapper.build_movie_from(content, genre), dates[content.id].pop)
        end
        client_attributes.liked.each do |content|
          next unless content.type == 'movie'

          genre = genre_mapper.build_genre_from(content.genres)
          client.likes(movie_mapper.build_movie_from(content, genre))
        end
        client
      end
    end
  end
end
