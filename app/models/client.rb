class Client
  attr_reader :email, :telegram_user_id, :contents_seen, :contents_liked
  attr_accessor :id

  def initialize(email, telegram_user_id, id = nil, email_validator = EmailValidator.new)
    raise NoEmailError if email.nil?

    email_validator.validate(email)

    @email = email
    @telegram_user_id = telegram_user_id
    @id = id
    @contents_seen = []
    @contents_liked = []
    @seen_this_with_amount = 3
  end

  def sees_content(content, date, client_repo)
    raise NotViewableContentError unless content.is_viewable

    @contents_seen << View.new(self, content, date)
    client_repo.update_contents_seen(self)
  end

  def saw_content?(content)
    @contents_seen.each do |view|
      return true if view.content == content
    end

    false
  end

  def seen_this_week(today)
    last_three = []
    this_week = this_week_seen_and_not_liked_dates(today)
    this_week.sort { |a, b| a.date <=> b.date }
    i = 0
    while i < @seen_this_with_amount && !this_week.empty?
      last_three.append(this_week.pop.content)
      i += 1
    end
    last_three
  end

  def likes(content, client_repo)
    @contents_liked << content
    client_repo.update_contents_liked(self)
  end

  def liked_content?(content)
    @contents_liked.include?(content)
  end

  private

  def this_week_seen_and_not_liked_dates(today)
    seven_days = 7 * 24 * 60 * 60
    this_week = []
    @contents_seen.each do |view|
      this_week.append(view) if view.date > today - seven_days && !@contents_liked.include?(view.content)
    end
    this_week
  end
end
