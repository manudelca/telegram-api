module Persistence
  module Repositories
    class SeasonsRepo < ROM::Repository[:seasons]
      private

      def seasons_changeset(season)
        {
          number: season.number
        }
      end
    end
  end
end
