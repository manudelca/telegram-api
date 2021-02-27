Given('the movie {string}, with type {string}, with audience {string}, duration {int} min, genre {string}, origin country {string}, director {string}, actors {string} and {string}, release date {string}') do |name, type, audience, duration, genre, country, director, first_actor, second_actor, release_date|
  @request = {name: genre}.to_json
  @response = Faraday.post(create_genre_url, @request, header)
  @request = {content: [{type: type, name: name, audience: audience,
                         duration_minutes: duration, genre: genre,
                         country: country, director: director,
                         first_actor: first_actor, second_actor: second_actor,
                         release_date: release_date}]}.to_json
  @response = Faraday.post(create_content_url, @request, header)

  content = JSON.parse(@response.body)
  @content_detail_id = content['content'].first['id']
  @content_like_id = content['content'].first['id']
end

Given('the tv show {string}, with type {string}, with audience {string}, duration {int} min, genre {string}, origin country {string}, director {string}, actors {string} and {string}, release date {string}, season {int} and episode {int}') do |name, type, audience, duration, genre, country, director, first_actor, second_actor, release_date, season, episode|
  @request = {name: genre}.to_json
  @response = Faraday.post(create_genre_url, @request, header)
  @request = {content: [{type: type, name: name, audience: audience,
                         duration_minutes: duration, genre: genre,
                         country: country, director: director,
                         first_actor: first_actor, second_actor: second_actor,
                         release_date: release_date,
                         season_number: season, episode_number: episode}]}.to_json
  @response = Faraday.post(create_content_url, @request, header)

  content = JSON.parse(@response.body)
  @content_detail_id = content['content'].first['tv_show_id']
  @content_like_id = content['content'].first['id']
end

When('I get the last movie created') do
  @response = Faraday.get(get_content_url(@content_detail_id))
end

When('I request details about the a none existant content') do
  @response = Faraday.get(get_content_url(-1))
end

When('I get the last tv_show created') do
  @response = Faraday.get(get_content_url(@content_detail_id))
end
