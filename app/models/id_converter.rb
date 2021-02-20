require_relative '../persistence/repositories/movie_repo'

class IdConverter
  attr_accessor :repos

  def initialize
    @movie_id = '00'
    @tv_show_id = '01'
    @episode_id = '02'
    @repos = {@movie_id => Persistence::Repositories::MovieRepo.new(DB),
              @tv_show_id => Persistence::Repositories::TvShowRepo.new(DB),
              @episode_id => Persistence::Repositories::EpisodesRepo.new(DB)}
  end

  def get_repo(id)
    repo_id_s = id.to_s
    last_int = repo_id_s[repo_id_s.length - 2, repo_id_s.length]
    @repos[last_int]
  end

  def parse_id(id)
    repo_id_s = id.to_s
    repo_id_s[0, repo_id_s.length - 2].to_i
  end

  def parse_any_id(id, addition)
    (id.to_s + addition).to_i
  end

  def parse_movie_id(id)
    parse_any_id(id, @movie_id)
  end

  def parse_tv_show_id(id)
    parse_any_id(id, @tv_show_id)
  end
end
