require_relative '../models/brewery'
require_relative '../models/beer'
require 'active_record'
require 'pg'
require 'sinatra'
require 'json'

database_config = ENV['DATABASE_URL']

if database_config.blank?
  database_config = YAML::load(File.open('config/database.yml'))
end

ActiveRecord::Base.establish_connection(database_config)

after do
  ActiveRecord::Base.connection.close
end

get '/' do
  send_file File.join(settings.public_folder, 'index.html')
end
