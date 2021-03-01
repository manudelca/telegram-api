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

When('I positive like content with id {int}') do |_int|
  @request = {telegram_user_id: @user_id, content_id: @content_like_id}.to_json
  @response = Faraday.post(like_url, @request, header)
end
