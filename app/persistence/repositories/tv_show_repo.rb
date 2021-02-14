module Persistence
  module Repositories
    class TvShowRepo < ROM::Repository[:contents]
      commands :create

      def create_content(tv_show)
        tv_show_struct = create(tv_show_changeset(tv_show))
        tv_show.id = tv_show_struct.id

        tv_show
      end

      def find(id)
        contents_relation = (contents.by_pk(id) >> tv_show_mapper)
        contents_relation.one
      end

      private

      def tv_show_changeset(tv_show)
        {
          name: tv_show.name,
          type: 'tv_show'
        }
      end

      def tv_show_mapper
        Persistence::Mappers::TvShowMapper.new
      end
    end
  end
end
