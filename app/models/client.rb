class Client
  attr_reader :email, :username
  attr_accessor :id

  def initialize(email, username, id = nil)
    @email = email
    @username = username
    @id = id
  end
end
