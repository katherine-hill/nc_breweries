require_relative '../lib/resources/beer'
require 'active_record'
require 'json'
require 'rack/test'
require 'rspec'
require 'pry'
require 'environment'

describe 'app' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

#  __  __     __   __     __     ______
# /\ \/\ \   /\ "-.\ \   /\ \   /\__  _\
# \ \ \_\ \  \ \ \-.  \  \ \ \  \/_/\ \/
#  \ \_____\  \ \_\\"\_\  \ \_\    \ \_\
#   \/_____/   \/_/ \/_/   \/_/     \/_/

  describe Beer do
    describe '#valid?' do
      context 'when only given a name' do
        it 'returns false' do
          beer = Beer.new(name: 'High Life')

          expect(beer.valid?).to eq false
        end
      end

      context 'when only given a kind' do
        it 'returns false' do
          beer = Beer.new(kind: 5)

          expect(beer.valid?).to eq false
        end
      end

      context 'when only given a description' do
        it 'returns false' do
          beer = Beer.new(description: 'Blue collar refined flavor')

          expect(beer.valid?).to eq false
        end
      end

      context 'when only given a rating' do
        it 'returns false' do
          beer = Beer.new(rating: 3)

          expect(beer.valid?).to eq false
        end
      end

      context 'when only given a brewery_id' do
        it 'returns false' do
          beer = Beer.new(brewery_id: 1)

          expect(beer.valid?).to eq false
        end
      end

      context 'when given all required parameters' do
        it 'returns true' do
          beer = Beer.new(name: 'High Life', kind: 5, description: 'Blue collar refined flavor', rating: 3, brewery_id: 1)

          expect(beer.valid?).to eq true
        end
      end
    end
  end

#  ______     ______   __
# /\  __ \   /\  == \ /\ \
# \ \  __ \  \ \  _-/ \ \ \
#  \ \_\ \_\  \ \_\    \ \_\
#   \/_/\/_/   \/_/     \/_/

  describe 'API #get /api/beer' do
    context 'calling all beers' do
      it 'returns all beers' do
        get '/api/beer'
          # binding.pry
        expect(last_response).to be_ok
        expect(last_response.body).to include('Fat')
        expect(last_response.status).to eq 200
      end
    end

    context 'when adding a search for kind' do
      it 'searches kind' do
        get '/api/beer?kind=7'

        expect(last_response).to be_ok
        expect(last_response.body).to include('Fat')
        expect(last_response.status).to eq 200
      end
    end

    context 'when adding a search by rating' do
      it 'searches rating' do
        get '/api/beer?rating=5'

        expect(last_response).to be_ok
        expect(last_response.body).to include('Fat')
        expect(last_response.status).to eq 200
      end
    end
  end

  describe 'API #get /api/beer/:id' do
    context 'calling one beer' do
      it 'returns a single beer' do
        get '/api/beer/2'
          # binding.pry
        expect(last_response).to be_ok
        expect(last_response.status).to eq 200
      end
    end
  end

  describe 'API #post /api/beer' do
    context 'creating a new beer' do
      it 'creates a single beer, associated with a brewery' do
        post '/api/beer?name=Fat%20Tire&kind=7&description=Very%20Good&rating=4&brewery_id=1'

        expect(last_response.body).to include('Fat')
        expect(last_response.status).to eq 201
      end
    end

    context 'incorrectly creating a new beer' do
      it 'fails to create a beer when missing values' do
        post '/api/beer?kind=7&description=Very%20Good&rating=4&brewery_id=1'

        expect(last_response.body).to include('Missing')
        expect(last_response.status).to eq 400
      end
    end
  end

  describe 'API #patch /api/beer' do
    context 'updates an existing beer' do
      it 'updates a single value or multiple values for a single beer.' do
        patch '/api/beer/2?name=Fat%20Face&rating=3&brewery_id=1'

        expect(last_response.body).to include('Face')
        expect(last_response.status).to eq 200
      end
    end

    context 'does not update an existing beer' do
      it 'fails to update a beer when missing brewery_id.' do
        patch '/api/beer/name=Fat%20Face&kind=8&rating=5&brewery_id=1'

        expect(last_response.status).to eq 400
      end
    end
  end

  describe 'API #delete /api/beer/:id' do
    context 'deleting a single beer' do
      it 'deletes a single beer by id' do
        # binding.pry
        delete '/api/beer/3'

        expect(Beer.find_by_id(3)).to eq nil
      end
    end
  end
end
