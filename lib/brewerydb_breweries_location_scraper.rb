require 'net/http'
require 'json'

breweries = []

api_key = '01c10819cca61c737eed29dec97819ee'

response = JSON.parse(File.read('data/breweries.json'))

response.each do |brewery|
  id = brewery['id']
  name = brewery['name']
  puts name

  url = URI("http://api.brewerydb.com/v2/brewery/#{id}/locations?key=#{api_key}")

  response = Net::HTTP.get(url)

  data = JSON.parse(response)

  status = data["status"]

  if status == "failure"
    puts "FAILURE: #{data['errorMessage']}"
    exit
  end

  unless data.key? 'data'
    puts "NO DATA FOR #{name}"
    p data
    next
  end

  data = data['data']

  regions = data.map { |location| location['region'] }

  brewery = {
    id: id,
    name: name,
    regions: regions
  }

  breweries << brewery
end

File.open('data/brewery_locations.json', 'w') do |f|
  f.write(breweries.to_json)
end
