require 'rom/transformer'

module Persistence
  module Mappers
    class EpisodeMapper
      def call(episodes)
        episodes.map do |episode|
          tv_show = tv_show_repo.find(episode.season.tv_show_id)
          season = season_mapper.build_season_from(episode.season, tv_show)
          build_episode_from(episode, season)
        end
      end

      def build_episode_from(episode_attributes, season)
        Episode.new(season, episode_attributes.number, episode_attributes.id)
      end

      def season_mapper
        SeasonMapper.new
      end

      def tv_show_repo
        Persistence::Repositories::TvShowRepo.new(DB)
      end
    end
  end
end
