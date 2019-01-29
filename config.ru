require './config/environment'
#require './app/controllers/application_controller'


#use Rack::MethodOveride
run ApplicationController
use TanksController