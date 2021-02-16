require 'rom/transformer'

module Persistence
  module Mappers
    class EpisodeMapper
      def call(episodes)
        episodes.map do |episode|
          build_episode_from(episode)
        end
      end

      def build_episode_from(episode_attributes)
        Episode.new(episode_attributes.number, episode_attributes.season_id, episode_attributes.id)
      end
    end
  end
end
