require 'net/http'
require 'json'

nc_breweries_with_beers = []

api_key = '82909bc0073c0a8b2d50370d341b3eea'

nc_breweries_file = File.read('data/nc_breweries.json')

nc_breweries = JSON.parse(nc_breweries_file)

nc_breweries.each do |brewery|
  id = brewery['id']
  name = brewery['name']
  location = brewery['location']

  puts name

  url = URI("http://api.brewerydb.com/v2/brewery/#{id}/beers?key=#{api_key}")

  response = Net::HTTP.get(url)

  data = JSON.parse(response)

  beers = data['data']

  if beers.nil?
    puts "WARN: beers nil? #{name}"
    next
  end

  beers = beers.map do |beer|
    category_name = nil

    if beer.key? 'style'
      style = beer['style']
      if style.key? 'category'
        category = style['category']
        if category.key? 'name'
          category_name = category['name']
        end
      end
    end

    {
      name: beer['name'],
      description: beer['description'],
      kind: category_name
    }
  end

  brewery = {
    name: name,
    location: location,
    beers: beers
  }

  nc_breweries_with_beers << brewery
end

File.open('data/nc_breweries_with_beers.json', 'w') do |f|
  f.write(nc_breweries_with_beers.to_json)
end
