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
        episode = build_episode_from(episode_attributes)
        tv_show = tv_show_repo.find(episode_attributes.tv_show_id)
        episode.tv_show = tv_show
        episode
      end

      def build_episode_from(episode_attributes)
        Episode.new(episode_attributes.episode_number, episode_attributes.season_number,
                    Time.parse(episode_attributes.release_date), episode_attributes.id)
      end

      def tv_show_repo
        Persistence::Repositories::TvShowRepo.new(DB)
      end
    end
  end
end
