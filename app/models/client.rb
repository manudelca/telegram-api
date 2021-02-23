require 'byebug'
class Client
  attr_reader :email, :telegram_user_id, :contents_seen, :contents_liked
  attr_accessor :id

  def initialize(email, telegram_user_id, id = nil, email_validator = EmailValidator.new)
    raise NoEmailError if email.nil?

    email_validator.validate(email)

    @email = email
    @telegram_user_id = telegram_user_id
    @id = id
    @contents_seen = {}
    @contents_liked = []
    @seen_this_with_amount = 3
  end

  def sees_content(content, date)
    @contents_seen[date] = content
  end

  def saw_content?(content)
    @contents_seen.each do |_date, content_seen|
      return true if content_seen == content
    end

    false
  end

  def seen_this_week(today)
    last_three = []
    this_week = this_week_seen_and_not_liked_dates(today)
    this_week.sort!
    i = 0
    while i < @seen_this_with_amount && !this_week.empty?
      last_three.append(@contents_seen[this_week.pop])
      i += 1
    end
    last_three
  end

  def likes(content)
    @contents_liked << content
  end

  def liked_content?(content)
    @contents_liked.include?(content)
  end

  private

  def this_week_seen_and_not_liked_dates(today)
    seven_days = 7 * 24 * 60 * 60
    this_week = []
    @contents_seen.each do |date, content|
      this_week.append(date) if date > today - seven_days && !@contents_liked.include?(content)
    end
    this_week
  end
end
