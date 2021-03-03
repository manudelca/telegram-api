class Content
  MAX_RELEASES_COUNT = 3
  MAX_WEATHER_SUGGESTIONS_COUNT = 3

  attr_accessor :id

  WEATHER_TO_GENRE = {'Clear' => 'comedia', 'Clouds' => 'accion'}.freeze

  def initialize(id = nil)
    @id = id
  end

  def self.releases(content_repo, date_provider)
    now_date = date_provider.now
    releases_before_now = content_repo.find_before_date_and_first_newer(now_date)
                                      .select(&:can_be_a_release).first(MAX_RELEASES_COUNT)
    return releases_before_now unless releases_before_now.empty?

    content_repo.find_after_date_and_first_nearer_in_time(now_date)
                .select(&:can_be_a_release).first(MAX_RELEASES_COUNT)
  end

  def self.weather_suggestions(content_repo, weather_provider, date_provider)
    weather = weather_provider.current_weather
    return releases(content_repo, date_provider) unless WEATHER_TO_GENRE.key?(weather)

    contents = content_repo.find_by_genre_name(WEATHER_TO_GENRE[weather])
                           .select(&:can_be_a_weather_suggestion).first(MAX_WEATHER_SUGGESTIONS_COUNT)

    return releases(content_repo, date_provider) if contents.empty?

    contents
  end

  def is_viewable
    raise ShoulBeImplementedInDerivedClassesError
  end

  def is_listable
    raise ShoulBeImplementedInDerivedClassesError
  end

  def can_be_a_release
    raise ShoulBeImplementedInDerivedClassesError
  end

  def can_be_a_weather_suggestion
    raise ShoulBeImplementedInDerivedClassesError
  end

  def ==(other)
    id == other.id
  end
end
