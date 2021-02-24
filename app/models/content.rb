class Content
  attr_accessor :id

  def initialize(id = nil)
    @id = id
  end

  def is_viewable
    raise ShoulBeImplementedInDerivedClassesError
  end
end
