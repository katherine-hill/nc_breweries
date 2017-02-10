require 'json'

def get_nc_breweries
  nc_breweries = []

  breweries = JSON.parse(File.read('data/brewery_locations.json'))

  breweries.each do |brewery|
    id = brewery['id']
    name = brewery['name']
    locations = brewery['locations']
    regions = locations.map { |location| location['region'] }

    if name == "Coors Brewing Company"
      next
    end

    if regions.include? 'North Carolina'
      locations = locations.select { |location| location['region'] == 'North Carolina' }

      if locations.length > 1
        puts "MORE THAN 1 LOCATION: #{name}"
        p locations
      end

      location = locations.first['locality']

      nc_brewery = { id: id, name: name, location: location }

      nc_breweries << nc_brewery
    end
  end

  nc_breweries
end

nc_breweries = get_nc_breweries

File.open('data/nc_breweries.json', 'w') do |f|
  f.write(nc_breweries.to_json)
end
