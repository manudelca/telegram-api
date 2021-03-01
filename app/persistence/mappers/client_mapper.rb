require 'rom/transformer'

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

      def tv_show_mapper
        TvShowMapper.new
      end

      def movie_mapper
        MovieMapper.new
      end

      def genre_mapper
        GenreMapper.new
      end

      def build_client_from(client_attributes)
        client = Client.new(client_attributes.email, client_attributes.telegram_user_id, client_attributes.id)
        contents_seen_dates = contents_seen_dates(client_attributes)
        add_contents_seen(client_attributes, client, contents_seen_dates)
        add_contents_liked(client_attributes, client)
        add_contents_listed(client_attributes, client)
        client
      end

      def contents_seen_dates(client_attributes)
        dates = {}
        client_attributes.contents_seen_date.each do |seen_date|
          if dates.key?(seen_date.content_id)
            dates[seen_date.content_id].append(seen_date.date)
          else
            dates[seen_date.content_id] = [seen_date.date]
          end
        end
        dates
      end

      def add_contents_seen(client_attributes, client, dates) # rubocop:disable Metrics/AbcSize
        client_attributes.seen.each do |content|
          case content.type
          when 'movie'
            genre = genre_mapper.build_genre_from(content.genres)
            client.sees_content(movie_mapper.build_movie_from(content, genre), Time.parse(dates[content.id].pop), client_repo)
          when 'episode'
            client.sees_content(episode_mapper.build_content_from_attributes(content), Time.parse(dates[content.id].pop), client_repo)
          end
        end
      end

      def add_contents_liked(client_attributes, client)
        client_attributes.liked.each do |content|
          case content.type
          when 'movie'
            genre = genre_mapper.build_genre_from(content.genres)
            client.likes(movie_mapper.build_movie_from(content, genre), client_repo)
          when 'episode'
            client.likes(episode_mapper.build_episode_from(content), client_repo)
          end
        end
      end

      def add_contents_listed(client_attributes, client)
        client_attributes.listed.each do |content|
          genre = genre_mapper.build_genre_from(content.genres)
          case content.type
          when 'movie'
            client.contents_listed << movie_mapper.build_movie_from(content, genre)
          when 'tv_show'
            client.contents_listed << tv_show_mapper.build_tv_show_from(content, genre)
          end
        end
      end

      def client_repo
        Persistence::Repositories::ClientRepo.new(DB)
      end
    end
  end
end
