class Content
  attr_accessor :id

  def initialize(id = nil)
    @id = id
  end

  # esto deberia quedar asi
  # def is_viewable
  #   raise ShoulBeImplementedInDerivedClassesError
  # end
end
