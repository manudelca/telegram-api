When('I register the movie {string}, with type {string}, with audience {string}, duration {int} min, genre {string}, origin country {string}, director {string}, actors {string} and {string}, release date {string} and the tv show episode {string}, with type {string}, with audience {string}, duration {int} min, genre {string}, origin country {string}, director {string}, actors {string} and {string}, release date {string}, season {int} and episode {int}') do |name, type, audience, duration, genre, country, director, first_actor, second_actor, release_date, tv_show_name, tv_show_type, tv_show_audience, tv_show_duration, tv_show_genre, tv_show_country, tv_show_director, tv_show_first_actor, tv_show_second_actor, tv_show_release_date, season, episode|
  @request = {content: [{type: type, name: name, audience: audience,
                         duration_minutes: duration, genre: genre,
                         country: country, director: director,
                         first_actor: first_actor, second_actor: second_actor,
                         release_date: release_date},
                        {type: tv_show_type, name: tv_show_name,
                         audience: tv_show_audience, duration_minutes: tv_show_duration,
                         genre: tv_show_genre, country: tv_show_country,
                         director: tv_show_director, release_date: tv_show_release_date,
                         first_actor: tv_show_first_actor, second_actor: tv_show_second_actor,
                         season_number: season, episode_number: episode}]}.to_json
  @response = Faraday.post(create_content_url, @request, header)
end

When('I register the movies {string}, with type {string}, with audience {string}, duration {int} min, genre {string}, origin country {string}, director {string}, actors {string} and {string}, release date {string} and {string}, with type {string}, with audience {string}, duration {int} min, genre {string}, origin country {string}, director {string}, actors {string} and {string}, release date {string}') do |name, type, audience, duration, genre, country, director, first_actor, second_actor, release_date, _string10, _string11, _string12, _int2, registered_genre, _string14, _string15, _string16, _string17, _string18|
  @request = {content: [{type: type, name: name, audience: audience,
                         duration_minutes: duration, genre: genre,
                         country: country, director: director,
                         first_actor: first_actor, second_actor: second_actor,
                         release_date: release_date},
                        {type: type, name: name, audience: audience,
                         duration_minutes: duration, genre: registered_genre,
                         country: country, director: director,
                         first_actor: first_actor, second_actor: second_actor,
                         release_date: release_date}]}.to_json
  @response = Faraday.post(create_content_url, @request, header)
end

When('I register a movie without name, with type {string}, with audience {string}, duration {int} min, genre {string}, origin country {string}, director {string}, actors {string} and {string}, release date {string}') do |type, audience, duration, genre, country, director, first_actor, second_actor, release_date,|
  @request = {content: [{type: type, audience: audience,
                         duration_minutes: duration, genre: genre,
                         country: country, director: director,
                         first_actor: first_actor, second_actor: second_actor,
                         release_date: release_date}]}.to_json
  @response = Faraday.post(create_content_url, @request, header)
end

When('I register the movies {string}, with type {string}, with audience {string}, duration {int} min, genre {string}, origin country {string}, director {string}, actors {string} and {string}, without release date') do |name, type, audience, duration, genre, country, director, first_actor, second_actor|
  @request = {content: [{type: type, name: name, audience: audience,
                         duration_minutes: duration, genre: genre,
                         country: country, director: director,
                         first_actor: first_actor, second_actor: second_actor}]}.to_json
  @response = Faraday.post(create_content_url, @request, header)
end
