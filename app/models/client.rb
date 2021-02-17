class Client
  attr_reader :email, :telegram_user_id, :movies_seen, :content_liked
  attr_accessor :id

  def initialize(email, telegram_user_id, id = nil)
    @email = email
    @telegram_user_id = telegram_user_id
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
