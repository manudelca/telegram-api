require 'rom/transformer'

module Persistence
  module Mappers
    class TvShowMapper
      def call(contents)
        contents.map do |tv_show_attributes|
          genre = genre_mapper.build_genre_from(tv_show_attributes.genres)
          seasons = []
          tv_show_attributes.seasons.each do |season_attributes|
            episodes = []
            season_attributes.episodes.each do |episode_attributes|
              episodes << episodes_mapper.build_episode_from(episode_attributes)
            end
            seasons << seasons_mapper.build_season_from(season_attributes, episodes)
          end
          build_tv_show_from(tv_show_attributes, genre, seasons)
        end
      end

      def build_tv_show_from(tv_show_attributes, genre, seasons)
        TvShow.new(tv_show_attributes.name,
                   tv_show_attributes.audience,
                   tv_show_attributes.duration_minutes,
                   genre,
                   tv_show_attributes.country,
                   tv_show_attributes.director,
                   tv_show_attributes.release_date,
                   tv_show_attributes.first_actor,
                   tv_show_attributes.second_actor,
                   tv_show_attributes.id,
                   seasons)
      end

      def genre_mapper
        GenreMapper.new
      end

      def seasons_mapper
        SeasonMapper.new
      end

      def episodes_mapper
        EpisodeMapper.new
      end
    end
  end
end
