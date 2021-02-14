class Client
  attr_reader :email
  attr_accessor :id

  def initialize(email, id = nil)
    @email = email
    @id = id
  end
end
