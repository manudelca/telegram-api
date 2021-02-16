module Persistence
  module Repositories
    class EpisodesRepo < ROM::Repository[:episodes]
      commands :create

      def create_episode(episode)
        episode_struct = create(episodes_changeset(episode))
        episode.id = episode_struct.id

        episode
      end

      def find(id)
        episodes_relation = episodes.combine(:seasons).by_pk(id)
        (episodes_relation >> episode_mapper).first
      end

      private

      def episodes_changeset(episode)
        {
          number: episode.number,
          season_id: episode.season.id
        }
      end

      def episode_mapper
        Persistence::Mappers::EpisodeMapper.new
      end
    end
  end
end