# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# puts "Deleting all movies..."
# Movie.destroy_all

require "json"
require "open-uri"

url = "http://tmdb.lewagon.com/movie/top_rated"
user_serialized = URI.open(url).read
datas = JSON.parse(user_serialized)
results = datas["results"].first(20)

puts "Creating movies"

results.each do |movie|
  new_movie = Movie.create!(title: movie["title"], overview: movie["overview"], poster_url: "https://image.tmdb.org/t/p/w500#{movie["poster_path"]}", rating: movie["vote_average"])
  puts "#{new_movie[:title]} a été créé."
end

puts "Finished !"
