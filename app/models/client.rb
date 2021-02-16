class Client
  attr_reader :email, :username, :movies_seen
  attr_accessor :id

  def initialize(email, username, id = nil)
    @email = email
    @username = username
    @id = id
    @movies_seen = []
    @episodes_seen = []
  end

  def sees_movie(movie)
    @movies_seen << movie
  end

  def sees_episode(episode)
    @episodes_seen << episode
  end

  def saw_movie?(movie)
    @movies_seen.include?(movie)
  end
end
