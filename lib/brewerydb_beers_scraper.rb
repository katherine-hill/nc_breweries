require 'json'

breweries = JSON.parse(File.read('data/brewery_locations.json'))

p breweries.count
