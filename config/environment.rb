require 'bundler'
Bundler.require
require 'rock-flash'
use Rack::Flash

configure :development do
	set :database, {adapter: "sqlite3", database: "db/database.sqlite3"}
end

#require_relative '../app/controllers/application_controller.rb'
require_all 'app'
