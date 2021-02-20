require_relative '../persistence/repositories/movie_repo'

class IdConverter
  attr_accessor :repos

  def initialize
    @repos = {0 => Persistence::Repositories::MovieRepo.new(DB),
              1 => Persistence::Repositories::TvShowRepo.new(DB),
              2 => Persistence::Repositories::EpisodesRepo.new(DB)}
  end

  def get_repo(id)
    repo_id_s = id.to_s
    last_int = repo_id_s[repo_id_s.length - 2, repo_id_s.length].to_i
    @repos[last_int]
  end
end
