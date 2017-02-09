require_relative '../resources/brewery'
require_relative '../resources/beer'
require 'active_record'
require 'pg'
require 'sinatra'
require 'json'
require 'yaml'
require_relative '../environment'

after do
  ActiveRecord::Base.connection.close
end

get '/' do
  send_file File.join(settings.public_folder, 'index.html')
end
