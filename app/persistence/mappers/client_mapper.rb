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

      def episode_mapper
        EpisodeMapper.new
      end

      def movie_mapper
        MovieMapper.new
      end

      def genre_mapper
        GenreMapper.new
      end

      def build_client_from(client_attributes)
        client = Client.new(client_attributes.email, client_attributes.telegram_user_id, client_attributes.id)
        movies_seen_dates = movies_seen_dates(client_attributes)
        episodes_seen_dates = episodes_seen_dates(client_attributes)
        add_movies_seen(client_attributes, client, movies_seen_dates)
        add_episodes_seen(client_attributes, client, episodes_seen_dates)
        add_movies_liked(client_attributes, client)
        client
      end

      def movies_seen_dates(client_attributes)
        dates = {}
        client_attributes.movies_seen_date.each do |seen_date|
          if dates.key?(seen_date.content_id)
            dates[seen_date.content_id].append(seen_date.date)
          else
            dates[seen_date.content_id] = [seen_date.date]
          end
        end
        dates
      end

      def episodes_seen_dates(client_attributes)
        dates = {}
        client_attributes.episodes_seen_date.each do |seen_date|
          if dates.key?(seen_date.episode_id)
            dates[seen_date.episode_id].append(seen_date.date)
          else
            dates[seen_date.episode_id] = [seen_date.date]
          end
        end
        dates
      end

      def add_movies_seen(client_attributes, client, dates)
        client_attributes.seen.each do |content|
          next unless content.type == 'movie'

          genre = genre_mapper.build_genre_from(content.genres)
          client.sees_movie(movie_mapper.build_movie_from(content, genre), Time.parse(dates[content.id].pop))
        end
      end

      def add_episodes_seen(client_attributes, client, dates)
        client_attributes.episodes_seen.each do |episode|
          client.sees_episode(episode_mapper.build_episode_from(episode), Time.parse(dates[episode.id].pop))
        end
      end

      def add_movies_liked(client_attributes, client)
        client_attributes.liked.each do |content|
          next unless content.type == 'movie'

          genre = genre_mapper.build_genre_from(content.genres)
          client.likes(movie_mapper.build_movie_from(content, genre))
        end
      end
    end
  end
end
