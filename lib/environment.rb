require 'active_record'
require 'yaml'

connection_details = ENV['DATABASE_URL']

if connection_details.blank?
  connection_details = YAML::load(File.open('config/database.yml'))
end

rack_env = ENV['RACK_ENV']
if rack_env.blank?
  connection_details = connection_details['development']
else
  connection_details = connection_details[rack_env]
end

ActiveRecord::Base.establish_connection(connection_details)
