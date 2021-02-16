module Persistence
  module Repositories
    class TvShowRepo < ROM::Repository[:contents]
      commands :create

      def create_content(tv_show)
        tv_show_struct = create(tv_show_changeset(tv_show))
        tv_show.id = tv_show_struct.id

        tv_show
      end

      def find_or_create(tv_show)
        contents_relation = contents.where(name: tv_show.name, director: tv_show.director,
                                           first_actor: tv_show.first_actor, second_actor: tv_show.second_actor,
                                           type: tv_show.type_of_content).combine(:genres, seasons: :episodes) # esta bien esto o es un abuso de notacion?
        tv_show_searched = (contents_relation >> tv_show_mapper).first
        return create_content(tv_show) if tv_show_searched.nil?

        tv_show_searched
      end

      def find(id)
        contents_relation = (contents.combine(:genres, seasons: :episodes).by_pk(id) >> tv_show_mapper)
        contents_relation.one
      end

      private

      def tv_show_changeset(tv_show)
        {
          name: tv_show.name,
          audience: tv_show.audience,
          duration_minutes: tv_show.duration_minutes,
          genre_id: tv_show.genre.id,
          country: tv_show.country,
          director: tv_show.director,
          release_date: tv_show.release_date,
          first_actor: tv_show.first_actor,
          second_actor: tv_show.second_actor,
          type: tv_show.type_of_content
        }
      end

      def tv_show_mapper
        Persistence::Mappers::TvShowMapper.new
      end
    end
  end
end
