require_relative '../../lib/models/beer'
require_relative '../../lib/models/brewery'

class PopulateBreweriesWithBeers < ActiveRecord::Migration[5.0]

  def up
    nc_breweries = JSON.parse(File.read('data/nc_breweries_with_beers.json'))

    nc_breweries.each do |nc_brewery|
      nc_brewery_name = nc_brewery['name']
      nc_brewery_location = nc_brewery['location']
      nc_brewery_beers = nc_brewery['beers']

      if nc_brewery_name == "Sierra Nevada Brewing Company"
        next
      end

      brewery = Brewery.create(name: nc_brewery_name, location: nc_brewery_location)

      nc_brewery_beers.each do |nc_beer|
        nc_beer_name = nc_beer['name']
        nc_beer_description = nc_beer['description']
        nc_beer_kind = nc_beer['kind']

        Beer.create(name: nc_beer_name, description: nc_beer_description, kind: nc_beer_kind, rating: 0, brewery: brewery)
      end
    end
  end

  def down
  end

end
