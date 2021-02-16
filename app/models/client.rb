class Client
  attr_reader :email, :username, :content_seen
  attr_accessor :id

  def initialize(email, username, id = nil)
    @email = email
    @username = username
    @id = id
    @content_seen = Set.new
  end

  def sees_content(content)
    @content_seen.add(content)
  end

  def amount_content_seen
    @content_seen.size
  end

  def saw_content?(content)
    @content_seen.include?(content)
  end
end
