Given('My user id is {int}') do |user_id|
  @user_id = user_id
end

When('I register as {string}') do |email|
  @request = {email: email, user_id: @user_id}.to_json
  @response = Faraday.post(client_url, @request, header)
end

When('I register without an email') do
  @request = {user_id: @user_id}.to_json
  @response = Faraday.post(client_url, @request, header)
end

Given('someone with id {int} registered as {string}') do |id, email|
  @request = {email: email, user_id: id}.to_json
  @response = Faraday.post(client_url, @request, header)
end
