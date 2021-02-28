class Content
  MAX_RELEASES_COUNT = 3
  MAX_WEATHER_SUGGESTIONS_COUNT = 3

  attr_accessor :id

  WEATHER_TO_GENRE = {'Clear': 'comedy'}.freeze

  def initialize(id = nil)
    @id = id
  end

  def self.releases(content_repo, now_date)
    releases_before_now = content_repo.find_before_date_and_first_newer(now_date)
                                      .select(&:can_be_a_release).first(MAX_RELEASES_COUNT)
    return releases_before_now unless releases_before_now.empty?

    content_repo.find_after_date_and_first_nearer_in_time(now_date)
                .select(&:can_be_a_release).first(MAX_RELEASES_COUNT)
  end

  def self.weather_suggestions(content_repo, _weather)
    content_repo.find_content_with_genre(genre)
                .select(&:can_be_a_weather_suggestion).first(MAX_WEATHER_SUGGESTIONS_COUNT)
  end

  def is_viewable
    raise ShoulBeImplementedInDerivedClassesError
  end

  def can_be_a_release
    raise ShoulBeImplementedInDerivedClassesError
  end
end
