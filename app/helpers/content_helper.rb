# Helper methods defined here can be accessed in any controller or view in the application

module WebTemplate
  class App
    module ContentHelper
      def create_content_and_get_json(content_type, content_params)
        dic_content_repo = {
          'movie' => method(:save_movie),
          'tv_show' => method(:save_tv_show)
        }
        dic_content_repo[content_type][content_params]
      end

      def save_movie(content_params)
        genre = genre_repo.find_by_genre_name(content_params['genre'])
        # Hay que definir que pasa si no lo encuentra...

        movie = Movie.new(content_params['name'],
                          content_params['audience'],
                          content_params['duration_minutes'],
                          genre,
                          content_params['country'],
                          content_params['director'],
                          content_params['release_date'],
                          content_params['first_actor'],
                          content_params['second_actor'])
        new_movie = movie_repo.create_content(movie)
        movie_to_json(new_movie)
      end

      def movie_repo
        Persistence::Repositories::MovieRepo.new(DB)
      end

      def save_tv_show(content_params) # rubocop:disable Metrics/AbcSize
        genre = genre_repo.find_by_genre_name(content_params['genre'])
        # Hay que definir que pasa si no lo encuentra...

        tv_show = TvShow.new(content_params['name'],
                             content_params['audience'],
                             content_params['duration_minutes'],
                             genre,
                             content_params['country'],
                             content_params['director'],
                             content_params['release_date'],
                             content_params['first_actor'],
                             content_params['second_actor'])
        new_tv_show = tv_show_repo.find_or_create(tv_show)

        # save season
        season = Season.new(content_params['season_number'], new_tv_show.id)
        new_season = seasons_repo.find_or_create(season)

        # save episode
        episode = Episode.new(content_params['episode_number'], new_season.id)
        new_episode = episodes_repo.create_episode(episode)

        create_tv_show_to_json(new_tv_show, new_season, new_episode)
      end

      def tv_show_repo
        Persistence::Repositories::TvShowRepo.new(DB)
      end

      def seasons_repo
        Persistence::Repositories::SeasonsRepo.new(DB)
      end

      def episodes_repo
        Persistence::Repositories::EpisodesRepo.new(DB)
      end

      def content_params
        @body ||= request.body.read
        JSON.parse(@body).symbolize_keys
      end

      private

      def movie_to_json(movie)
        {
          id: movie.id,
          name: movie.name,
          audience: movie.audience,
          duration_minutes: movie.duration_minutes,
          genre: movie.genre.name,
          country: movie.country,
          director: movie.director,
          release_date: movie.release_date,
          first_actor: movie.first_actor,
          second_actor: movie.second_actor
        }
      end

      def movie_details_to_json(movie)
        {
          id: movie.id,
          name: movie.name,
          audience: movie.audience,
          duration_minutes: movie.duration_minutes,
          genre: movie.genre.name,
          country: movie.country,
          director: movie.director,
          first_actor: movie.first_actor,
          second_actor: movie.second_actor
        }
      end

      def create_tv_show_to_json(tv_show, season, episode)
        {
          id: episode.id,
          name: tv_show.name,
          audience: tv_show.audience,
          duration_minutes: tv_show.duration_minutes,
          genre: tv_show.genre.name,
          country: tv_show.country,
          director: tv_show.director,
          release_date: tv_show.release_date,
          first_actor: tv_show.first_actor,
          second_actor: tv_show.second_actor,
          season_number: season.number,
          episode_number: episode.number
        }
      end
    end

    helpers ContentHelper
  end
end
