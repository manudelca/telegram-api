module Persistence
  module Repositories
    class SeasonsRepo < ROM::Repository[:seasons]
      commands :create

      def create_season(season, tv_show_id)
        season_struct = create(seasons_changeset(season, tv_show_id))
        season.id = season_struct.id

        season
      end

      def find(id)
        seasons_relation = (seasons.by_pk(id) >> season_mapper)
        seasons_relation.one
      end

      private

      def seasons_changeset(season, tv_show_id)
        {
          number: season.number,
          tv_show_id: tv_show_id
        }
      end

      def season_mapper
        Persistence::Mappers::SeasonMapper.new
      end
    end
  end
end
