Given('My id is {string}') do |user_id|
  @user_id = user_id
end

When('I register as {string}') do |email|
  @request = {email: email, user_id: @user_id}.to_json
  @response = Faraday.post(client_url, @request, header)
end
