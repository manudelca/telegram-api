module Persistence
  module Repositories
    class EpisodesRepo < ROM::Repository[:contents]
      commands :create

      def create_episode(episode)
        episode_struct = create(episodes_changeset(episode))
        episode.id = episode_struct.id

        episode
      end

      def find(id)
        episodes_relation = contents.by_pk(id)
        episode = (episodes_relation >> episode_mapper).first
        raise ContentNotFound if episode.nil?

        episode
      end

      def delete_all
        episodes.delete
      end

      private

      def episodes_changeset(episode)
        {
          episode_number: episode.number,
          season: episode.season_id,
          type: 'episode'
        }
      end

      def episode_mapper
        Persistence::Mappers::EpisodeMapper.new
      end
    end
  end
end
