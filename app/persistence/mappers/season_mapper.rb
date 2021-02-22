require 'rom/transformer'

module Persistence
  module Mappers
    class SeasonMapper
      def call(seasons)
        seasons.map do |season_attributes|
          episodes = []
          season_attributes.episodes.each do |episode_attributes|
            episodes << episodes_mapper.build_episode_from(episode_attributes)
          end
          build_season_from(season_attributes, episodes)
        end
      end

      def build_season_from(season_attributes, episodes)
        Season.new(season_attributes.number,
                   season_attributes.tv_show_id,
                   season_attributes.release_date,
                   season_attributes.id,
                   episodes)
      end

      def episodes_mapper
        EpisodeMapper.new
      end
    end
  end
end
