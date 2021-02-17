Given('the movie {string}, with audience {string}, duration {int} min, genre {string}, origin country {string}, director {string}, actors {string} and {string} is available with id {int}') do |name, audience, duration, genre, country, director, first_actor, second_actor, _id|
  @request = {content: [{type: 'movie', name: name, audience: audience,
                         duration_minutes: duration, genre: genre,
                         country: country, director: director,
                         first_actor: first_actor, second_actor: second_actor,
                         release_date: '2021-01-01'}]}.to_json
  @response = Faraday.post(create_content_url, @request, header)

  content = JSON.parse(@response.body)
  @content_id = content['content'].first['id']
end

Given('I saw content with id {int}') do |_int|
  @request = {username: @username, content_id: @content_id}.to_json
  Faraday.patch(views_url, @request, header)
end

Given('I haven\'t liked the content with id {int}') do |int|
end

When('I positive like content with id {int}') do |_int|
  @request = {username: @username, content_id: @content_id}.to_json
  @response = Faraday.post(like_url, @request, header)
end
