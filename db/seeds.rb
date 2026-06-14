# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "open-uri"
require "json"

Movie.destroy_all
puts "Tous les movies ont été supprimés"

5.times do |i|
  url = "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV["TMDB_API_KEY"]}&language=fr-FR&page=#{i + 1}"

  response = URI.open(url).read
  data = JSON.parse(response)

  data["results"].each do |movie|
    Movie.find_or_create_by(title: movie["title"]) do |m|
      m.overview = movie["overview"]
      m.poster_url = "https://image.tmdb.org/t/p/w500#{movie["poster_path"]}"
      m.rating = movie["vote_average"]
    end
  end
end

puts "#{Movie.count} films créés."
