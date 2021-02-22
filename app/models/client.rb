class Client
  attr_reader :email, :telegram_user_id, :movies_seen, :content_liked
  attr_accessor :id

  def initialize(email, telegram_user_id, id = nil, email_validator = EmailValidator.new)
    raise NoEmailError if email.nil?

    email_validator.validate(email)

    @email = email
    @telegram_user_id = telegram_user_id
    @id = id
    @movies_seen = {}
    @episodes_seen = []
    @content_liked = []
  end

  def sees_movie(movie, date)
    @movies_seen[date] = movie
  end

  def sees_episode(episode)
    @episodes_seen << episode
  end

  def saw_movie?(movie)
    @movies_seen.each do |_date, content|
      return true if content == movie
    end

    false
  end

  def seen_this_week(date)
    seven_days = 7 * 24 * 60 * 60
    content_date = Time.parse('2021-01-01')
    contents = []
    contents.append(@movies_seen[content_date]) if content_date > date - seven_days
    contents
  end

  def likes(content)
    @content_liked << content
  end

  def liked_content?(content)
    @content_liked.include?(content)
  end
end
