require_relative '../persistence/repositories/movie_repo'

class IdConverter
  attr_accessor :repos

  def initialize
    @repos = {'00' => Persistence::Repositories::MovieRepo.new(DB),
              '01' => Persistence::Repositories::TvShowRepo.new(DB)}
  end

  def get_repo(id)
    repo_id = id[0, 2]
    @repos[repo_id]
  end
end
