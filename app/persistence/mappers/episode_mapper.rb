require 'rom/transformer'

module Persistence
  module Mappers
    class EpisodeMapper
      def call(episodes)
        episodes.map do |episode_attributes|
          build_episode_from(episode_attributes)
        end
      end

      def build_content_from_attributes(episode_attributes)
        build_episode_from(episode_attributes)
      end

      def build_episode_from(episode_attributes)
        Episode.new(episode_attributes.episode_number, episode_attributes.season_number,
                    episode_attributes.release_date, episode_attributes.tv_show_id, episode_attributes.id)
      end
    end
  end
end
