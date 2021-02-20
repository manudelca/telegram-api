require_relative '../persistence/repositories/movie_repo'

class IdConverter
  def get_repo(_id)
    Persistence::Repositories::MovieRepo.new(DB)
  end
end
