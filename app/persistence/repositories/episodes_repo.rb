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

      def find_by_tv_show_id(tv_show_id)
        episodes_relation = (contents.where(tv_show_id: tv_show_id) >> episode_mapper)
        episodes = []
        episodes_relation.each { |episode| episodes << episode }
        episodes
      end

      def find_by_tv_show_id_number_season_and_release_date(tv_show_id, number, season, release_date)
        episodes_relation = contents.where(tv_show_id: tv_show_id)
                                    .where(episode_number: number)
                                    .where(season_number: season)
                                    .where(release_date: release_date)
        episodes_relation = (episodes_relation >> episode_mapper)
        episodes_relation.first
      end

      private

      def episodes_changeset(episode)
        {
          episode_number: episode.number,
          season_number: episode.season_number,
          tv_show_id: episode.tv_show.id,
          release_date: episode.release_date,
          type: 'episode'
        }
      end

      def episode_mapper
        Persistence::Mappers::EpisodeMapper.new
      end
    end
  end
end
