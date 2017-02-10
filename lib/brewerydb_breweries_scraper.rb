require 'net/http'
require 'json'

module BreweryAPI
  class BreweriesScraper
    def initialize
      @api_key = '82909bc0073c0a8b2d50370d341b3eea'
    end

    def get_breweries
      year_established = 2017

      min_year_established = 1773

      all_breweries = []

      (min_year_established..year_established).each do |year|
        puts year

        all_breweries = all_breweries.concat(get_breweries_by_year(year))
      end

      all_breweries
    end

    private
      def get_breweries_by_year(year_established)
        all_breweries = []

        page_number = 0

        loop do
          page_number += 1

          data = get_breweries_by_year_and_page(year_established, page_number)

          breweries = data['data']

          break if breweries.nil?

          breweries.each do |brewery|
            id = brewery['id']
            name = brewery['name']

            all_breweries << { id: id, name: name }
          end

          number_of_pages = data['numberOfPages'].to_i

          break if page_number >= number_of_pages
        end

        all_breweries
      end

      def get_breweries_by_year_and_page(year_established, page_number)
        url = URI("http://api.brewerydb.com/v2/breweries?key=#{@api_key}&established=#{year_established}&p=#{page_number}")

        response = Net::HTTP.get(url)

        data = JSON.parse(response)
      end

  end
end

api = BreweryAPI::BreweriesScraper.new

breweries = api.get_breweries

File.open('data/breweries.json', 'w') do |f|
  f.write(breweries.to_json)
end
