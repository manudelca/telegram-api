When('I register as {string}') do |email|
  @request = {email: email}.to_json
  @response = Faraday.post(register_url, @request, header)
end
