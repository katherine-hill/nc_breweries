require 'net/http'
require 'json'


breweries = JSON.parse(File.read('data/brewery_locations.json'))

NCBrewery {
    id => id,
    name => name,
    regions => regions
  }


nc_breweries = []

def get_nc_breweries
  breweries.each do
    if region.downcase == "north carolina"
      nc_brewery = NCBrewery.new(:id = id, :name = name, region = "North Carolina")

      nc_breweries < nc_breweries
  end
end

p nc_breweries
