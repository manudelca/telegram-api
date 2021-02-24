# rubocop:disable all
ENV['RACK_ENV'] = 'test'
ENV['ENABLE_RESET'] = 'true'

require File.expand_path("#{File.dirname(__FILE__)}/../../config/boot")

require 'rspec/expectations'

if ENV['BASE_URL']
  BASE_URL = ENV['BASE_URL']
else
  BASE_URL = 'http://localhost:3000'.freeze
  include Rack::Test::Methods
  def app
    Padrino.application
  end
end

def header
  {'Content-Type' => 'application/json'}
end

def find_user_url(user_id)
  "#{BASE_URL}/users/#{user_id}"
end

def find_task_url(task_id)
  "#{BASE_URL}/tasks/#{task_id}"
end

def update_user_url(user_id)
  "#{BASE_URL}/users/#{user_id}"
end

def find_all_users_url
  "#{BASE_URL}/users"
end

def create_user_url
  "#{BASE_URL}/users"
end

def create_task_url
  "#{BASE_URL}/tasks"
end

def create_tag_url
  "#{BASE_URL}/tags"
end

def add_tag_to_task_url(task_id)
  "#{BASE_URL}/tasks/add_tag/#{task_id}"
end

def delete_user_url(user_id)
  "#{BASE_URL}/users/#{user_id}"
end

def reset_url
  "#{BASE_URL}/reset"
end

def create_genre_url
  "#{BASE_URL}/genre"
end

def create_content_url
  "#{BASE_URL}/content"
end

def get_releases_url
  "#{BASE_URL}/releases"
end

def client_url
  "#{BASE_URL}/register"
end

def views_url(email, content_id)
  "#{BASE_URL}/clients/#{email}/contents/#{content_id}/seen"
end

def get_content_url(content_id)
  "#{BASE_URL}/content/#{content_id}"
end

def like_url
  "#{BASE_URL}/like"
end

def test_date_url
  "#{BASE_URL}/date"
end

def seen_this_week_url
  "#{BASE_URL}/seen_this_week"
end

After do |_scenario|
  Faraday.post(reset_url)
end
