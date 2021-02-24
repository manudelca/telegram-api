class Content
  attr_accessor :id

  def initialize(id = nil)
    @id = id
  end

  def self.releases(content_repo, now_date)
    content_repo.find_before_date_and_first_newer(now_date).select(&:can_be_a_release)
  end

  def is_viewable
    raise ShoulBeImplementedInDerivedClassesError
  end

  def can_be_a_release
    raise ShoulBeImplementedInDerivedClassesError
  end
end
