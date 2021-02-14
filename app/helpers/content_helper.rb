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
        movie = Movie.new(content_params[:name])
        new_movie = movie_repo.create_content(movie)
        movie_to_json(new_movie)
      end

      def movie_repo
        Persistence::Repositories::MovieRepo.new(DB)
      end

      def save_tv_show(content_params)
        tv_show = TvShow.new(content_params[:name])
        new_tv_show = movie_repo.create_content(tv_show)

        # save season
        season = Season.new(new_tv_show, content_params[:season])
        new_season = seasons_repo.create_season(season)

        # save episode
        episode = Episode.new(new_season, content_params[:episode])
        new_episode = episodes_repo.create_episode(episode)

        tv_show_to_json(new_season, new_season, new_episode)
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
          name: movie.name
        }
      end

      def tv_show_to_json(tv_show, _season, _episode)
        {
          id: tv_show.id,
          name: tv_show.name
        }
      end
    end

    helpers ContentHelper
  end
end
