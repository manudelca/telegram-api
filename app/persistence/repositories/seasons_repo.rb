module Persistence
  module Repositories
    class SeasonsRepo < ROM::Repository[:seasons]
      commands :create

      def create_season(season)
        season_struct = create(seasons_changeset(season))
        season.id = season_struct.id

        season
      end

      def find_or_create(season)
        seasons_relation = seasons.where(tv_show_id: season.tv_show.id, number: season.number).combine(:contents)  # esta bien esto o es un abuso de notacion?
        season_searched = (seasons_relation >> season_mapper).first
        return create_season(season) if season_searched.nil?

        season_searched
      end

      def find(id)
        seasons_relation = seasons.combine(:contents).by_pk(id)
        (seasons_relation >> season_mapper).first
      end

      private

      def seasons_changeset(season)
        {
          number: season.number,
          tv_show_id: season.tv_show.id
        }
      end

      def season_mapper
        Persistence::Mappers::SeasonMapper.new
      end
    end
  end
end
