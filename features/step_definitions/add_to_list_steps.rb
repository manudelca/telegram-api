Given('the movie {string}, with audience {string}, duration {int} min, genre {string}, origin country {string}, director {string}, actors {string} and {string}, release date {string} is available') do |string, string2, int, string3, string4, string5, string6, string7, string8|
  @request = {name: string3}.to_json
  @response = Faraday.post(create_genre_url, @request, header)
  @request = {content: [{type: 'movie', name: string, audience: string2,
                         duration_minutes: int, genre: string3,
                         country: string4, director: string5,
                         first_actor: string6, second_actor: string7,
                         release_date: string8}]}.to_json
  @response = Faraday.post(create_content_url, @request, header)

  content = JSON.parse(@response.body)
  @content_id = content['content'].first['id']
end

Given('I register myself with the email {string}') do |email|
  @user_id = 999
  @request = {email: email, telegram_user_id: @user_id}.to_json
  @response = Faraday.post(client_url, @request, header)
end

When('I add the movie to my list') do
  @response = Faraday.patch(lists_url(@user_id, @content_id), nil, header)
end

When('I add the movie to a non-existant clien list') do
  non_existant_user_id = -1
  @response = Faraday.patch(lists_url(non_existant_user_id, @content_id), nil, header)
end

When('I add the tv show {string} to my list') do |_string|
  @response = Faraday.patch(lists_url(@user_id, @content_detail_id), nil, header)
end

When('I add a non-existant movie to my list') do
  @response = Faraday.patch(lists_url(@user_id, -1), nil, header)
end
