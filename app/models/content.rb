class Content
  attr_accessor :id

  def initialize(id = nil)
    @id = id
  end

  # def seen(client_id, date)
  #   raise NotViewableContentError unless is_viewable
  #   View.new(id, client_id, date)
  # end

  # def is_viewable
  #   raise ShoulBeImplementedInDerivedClassesError
  # end
end
