class ApiKeyProvider
  def initialize
    @settable_api_key = nil
  end

  def define_api_key(api_key)
    @settable_api_key = api_key
  end

  def clean_api_key
    @settable_api_key = nil
  end

  def api_key
    return @settable_api_key unless @settable_api_key.nil?

    ENV['WEBAPI_API_KEY']
  end
end
