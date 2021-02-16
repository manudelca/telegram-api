Given('My username is {string}') do |username|
  @username = username
end

When('I register as {string}') do |email|
  @request = {email: email, username: @username}.to_json
  @response = Faraday.post(client_url, @request, header)
end
