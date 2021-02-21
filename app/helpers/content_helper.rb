# Helper methods defined here can be accessed in any controller or view in the application

module WebTemplate
  class App
    module ContentHelper
      def find_content(content_id)
        id_conversor = IdConverter.new
        repo = id_conversor.get_repo(content_id)
        repo.find(id_conversor.parse_id(content_id))
        pp repo.find(id_conversor.parse_id(content_id))
      end

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
        new_movie.full_details
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
        season = Season.new(content_params['season_number'],
                            new_tv_show.id,
                            content_params['release_date'])
        new_season = seasons_repo.find_or_create(season)

        # save episode
        episode = Episode.new(content_params['episode_number'], new_season.id)
        new_episode = episodes_repo.create_episode(episode)

        new_tv_show.full_details(new_season, new_episode)
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
    end

    helpers ContentHelper
  end
end
