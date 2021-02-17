class Client
  attr_reader :email, :username, :movies_seen
  attr_accessor :id

  def initialize(email, username, id = nil)
    @email = email
    @username = username
    @id = id
    @movies_seen = []
    @episodes_seen = []
    @content_liked = []
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

  def likes(content)
    @content_liked << content
  end

  def liked_content?(content)
    @content_liked.include?(content)
  end
end
