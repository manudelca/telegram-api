require 'byebug'
Given('I am registered as {string}') do |email|
  @user_id = 999
  @email = email
  @request = {email: @email, telegram_user_id: @user_id}.to_json
  @response = Faraday.post(client_url, @request, header)
end

Given('I saw content with id {int}') do |_int|
  @response = Faraday.patch(views_url(@email, @content_like_id), nil, header)
end

Given('I haven\'t liked the content with id {int}') do |int|
end

Given("I haven't seen content with id {int}") do |int|
end

Given('I saw {string} season {int} episode {int}') do |name, _season, episode|
  @response = Faraday.patch(views_url(@email, @episodes[name][episode]), nil, header)
end

Given('I positive liked {string} season {int} episode {int}') do |name, _season, episode|
  @request = {telegram_user_id: @user_id, content_id: @episodes[name][episode]}.to_json
  Faraday.post(like_url, @request, header)
end

When('I positive like {string}') do |_string|
  @request = {telegram_user_id: @user_id, content_id: @tv_show_id}.to_json
  @response = Faraday.post(like_url, @request, header)
end

When('I positive like content with id {int}') do |_int|
  @request = {telegram_user_id: @user_id, content_id: @content_like_id}.to_json
  @response = Faraday.post(like_url, @request, header)
end
