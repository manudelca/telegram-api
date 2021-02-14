module Persistence
  module Repositories
    class EpisodesRepo < ROM::Repository[:episodes]
      private

      def episodes_changeset(episode)
        {
          number: episode.number
        }
      end
    end
  end
end
