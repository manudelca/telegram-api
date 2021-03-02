require 'dotenv/load'

@@weather = WeatherProvider.new # rubocop:disable Style/ClassVars
@@date_provider = DateProvider.new # rubocop:disable Style/ClassVars
@@api_key_provider = ApiKeyProvider.new # rubocop:disable Style/ClassVars

module WebTemplate
  class App < Padrino::Application
    register Padrino::Mailer
    register Padrino::Helpers

    before do
      unless request.env['HTTP_AUTHORIZATION'] == @@api_key_provider.api_key ||
             (request.env['Authorization'] == @@api_key_provider.api_key && ENV['RACK_ENV'] == 'test') ||
             request.env['PATH_INFO'] == '/api_key'
        halt 401,
             {'Content-Type' => 'application/json'},
             { message: 'Not authorized Error'}.to_json
      end
    end

    get '/' do
      "It\'s alive! version: #{Version.current}"
    end

    post '/reset', :provides => [:js] do
      if ENV['ENABLE_RESET'] == 'true'
        client_repo.delete_all
        content_repo.delete_all
        genre_repo.delete_all
        @@date_provider.clean_now_date
        @@api_key_provider.clean_api_key
        @@weather.clean_weather

        status 200
        {message: 'reset ok'}.to_json
      else
        status 403
        {message: 'reset not enabled'}.to_json
      end
    end

    post '/date' do
      input = JSON.parse(request.body.read)
      @@date_provider.define_now_date(Time.parse(input['date']))

      status 200
      {message: 'ok'}.to_json
    end

    post '/api_key' do
      input = JSON.parse(request.body.read)
      @@api_key_provider.define_api_key(input['api_key'])

      status 200
      {message: 'ok'}.to_json
    end

    post '/weather' do
      input = JSON.parse(request.body.read)
      @@weather.define_weather(input['weather'])

      status 200
      {message: 'ok'}.to_json
    end

    get :docs, map: '/docs' do
      render 'docs'
    end

    ##
    # Caching support.
    #
    # register Padrino::Cache
    # enable :caching
    #
    # You can customize caching store engines:
    #
    # set :cache, Padrino::Cache.new(:LRUHash) # Keeps cached values in memory
    # set :cache, Padrino::Cache.new(:Memcached) # Uses default server at localhost
    # set :cache, Padrino::Cache.new(:Memcached, :server => '127.0.0.1:11211', :exception_retry_limit => 1)
    # set :cache, Padrino::Cache.new(:Memcached, :backend => memcached_or_dalli_instance)
    # set :cache, Padrino::Cache.new(:Redis) # Uses default server at localhost
    # set :cache, Padrino::Cache.new(:Redis, :host => '127.0.0.1', :port => 6379, :db => 0)
    # set :cache, Padrino::Cache.new(:Redis, :backend => redis_instance)
    # set :cache, Padrino::Cache.new(:Mongo) # Uses default server at localhost
    # set :cache, Padrino::Cache.new(:Mongo, :backend => mongo_client_instance)
    # set :cache, Padrino::Cache.new(:File, :dir => Padrino.root('tmp', app_name.to_s, 'cache')) # default choice
    #

    ##
    # Application configuration options.
    #
    # set :raise_errors, true       # Raise exceptions (will stop application) (default for test)
    # set :dump_errors, true        # Exception backtraces are written to STDERR (default for production/development)
    # set :show_exceptions, true    # Shows a stack trace in browser (default for development)
    # set :logging, true            # Logging in STDOUT for development and file for production (default only for development)
    # set :public_folder, 'foo/bar' # Location for static assets (default root/public)
    # set :reload, false            # Reload application files (default in development)
    # set :default_builder, 'foo'   # Set a custom form builder (default 'StandardFormBuilder')
    # set :locale_path, 'bar'       # Set path for I18n translations (default your_apps_root_path/locale)
    # disable :sessions             # Disabled sessions by default (enable if needed)
    # disable :flash                # Disables sinatra-flash (enabled by default if Sinatra::Flash is defined)
    # layout  :my_layout            # Layout can be in views/layouts/foo.ext or views/foo.ext (default :application)
    #

    ##
    # You can configure for a specified environment like:
    #
    #   configure :development do
    #     set :foo, :bar
    #     disable :asset_stamp # no asset timestamping for dev
    #   end
    #

    ##
    # You can manage errors like:
    #
    #   error 404 do
    #     render 'errors/404'
    #   end
    #
    #   error 500 do
    #     render 'errors/500'
    #   end
    #
  end
end
