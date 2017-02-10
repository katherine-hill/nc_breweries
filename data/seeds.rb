require 'csv'
require_relative '../lib/environment'
require_relative '../lib/resources/api'

def load_brewery_data
  CSV.foreach('/Users/DougEisner/Documents/TIY/week5/nc_breweries/data/breweries.csv', headers: true) do |row|
    name = row['name']
    location = row['location']

    Brewery.new(name: name, location: location).save
  end
end

def load_beers_data
  CSV.foreach('/Users/DougEisner/Documents/TIY/week5/nc_breweries/data/beers.csv', headers: true) do |row|
    name = row['name']
    kind = row['kind']
    description = row['description']
    rating = row['rating']
    brewery_id = row['brewery_id']

    Beer.new(name: name, kind: kind, description: description, rating: rating, brewery_id: brewery_id).save
  end
end

def main
  load_brewery_data
  load_beers_data
end

main if __FILE__ == $PROGRAM_NAME
