<!--
 ______     ______     ______     __     __     ______     ______     __  __
/\  == \   /\  == \   /\  ___\   /\ \  _ \ \   /\  ___\   /\  == \   /\ \_\ \
\ \  __<   \ \  __<   \ \  __\   \ \ \/ ".\ \  \ \  __\   \ \  __<   \ \____ \
 \ \_____\  \ \_\ \_\  \ \_____\  \ \__/".~\_\  \ \_____\  \ \_\ \_\  \/\_____\
  \/_____/   \/_/ /_/   \/_____/   \/_/   \/_/   \/_____/   \/_/ /_/   \/_____/
-->

# GET '/api/brewery' do
  Brewery.all.to_json
end

validates brewery table not nil
returns all breweries as Json object [{ id: 1, name: 'name', location: 'location' }, ... {}]
status 200 on success
status 404 when there are no breweries

# GET '/api/brewery/:id' do
  {id = int}
  Brewery.find_by_id(id)
end

receives id via query string parameter
validates id not nil
returns single brewery as json object [{ id: 1, name: 'name', location: 'location' }]
returns all beers by that brewery as json  array i.e. [{id: '1', name: 'name', kind: '7', description: 'long description', rating: 'rating', brewery_id: 'brewery_id'}...{}]
status 200 on success
status 404 when id does not exist

# POST '/api/brewery' do
  {
  name = string
  location = string
  }

  Brewery.create(params)
end

validates name & location are not blank
sends a json object via body [{name: 'name', location: 'location'}]
creates a new brewery
status 201 on success
status 404 when params are missing

# PATCH '/api/brewery/:id' do
  Brewery.find_by_id(id)
    {id = int
    name = string
    location = string
    }

  Brewery.update(params)
end

receives id via query string parameter
validates id not nil
validates name & location are not blank
updates a brewery with given body params as json i.e. [{name: 'name'}]
status 200 on successful update
status 404 on failing to provide valid params

# DELETE '/api/brewery/:id' do
  task = Task.find_by_id(id)
  task.destroy
end

receives id via query string parameter
validates id not nil
deletes a brewery by id
status 200 on successful delete
status 404 if brewery has beer associated by foreign key

  <!--
 ______     ______     ______     ______
/\  == \   /\  ___\   /\  ___\   /\  == \
\ \  __<   \ \  __\   \ \  __\   \ \  __<
 \ \_____\  \ \_____\  \ \_____\  \ \_\ \_\
  \/_____/   \/_____/   \/_____/   \/_/ /_/
  -->

# GET '/api/beer' do
  Beer.all.to_json
end

validates beer table not nil
returns all beers as json [{id: '1', name: 'name', kind: '7', description: 'long description', rating: 'rating', brewery_id: 'brewery_id'}...{}]
status 200 on success
status 404 when beer table empty


# GET '/api/beer/:id' do
  {id = int}
  Beer.find_by_id(id)
end

receives id via query string parameter
validates id not nil
returns single beer as json [{id: '1', name: 'name', kind: '7', description: 'long description', rating: 'rating', brewery_id: 'brewery_id'}]
status 200 on success
status 404 on failing to provide id

# POST '/api/beer' do
  {
  name = string
  kind = int
  description = string
  rating = int
  }

  Beer.create(params)
end

validates name, kind, description, rating, and brewery_id are not blank
sends a beer in body as json [{name: 'name', kind: '7', description: 'long description', rating: 'rating' brewery_id: 'brewery_id'}]
creates beer
status 201 on success
status 404 on failing to provide all parameters

# PATCH '/api/beer/int' do
  Beer.find_by_id(id)
    {
    id = int
    name = string
    kind = int
    description = string
    rating = int
    }


  Beer.update(params)
end

receives id via query string parameter
validates id not nil
updates a beer in body as json [{name: 'name', kind: '7', description: 'long description', rating: 'rating'}]
validates updated parameters
status 200 on success
status 404 for failing to provide all parameters

# DELETE '/api/beer/:id' do
  task = Task.find_by_id(id)
  task.destroy
end

receives id via query string parameter
validates id not nil
deletes a beer
status 200 on success
status 404 if id nil
