module Persistence
  module Repositories
    class TvShowRepo < ROM::Repository[:contents]
      private

      def tv_show_changeset(tv_show)
        { name: tv_show.name }
      end
    end
  end
end
