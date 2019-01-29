require "./config/environment"
require "./app/models/user"
class ApplicationController < Sinatra::Base

  configure do
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
    #@is_logged_in = helpers.logged_in?
    erb :welcome
  end

  get "/signup" do
    erb :signup
  end

  post "/signup" do
    username = params[:username]
    password = params[:password]
    if !username || username.length == 0 || !password || password.length == 0
      puts "redirect no password"
      redirect "/failure"
    else 
      puts "go to login"
      user = User.create(:username => username, :password => password)
      user.save
      redirect "/users/login"
    end
  end

  get '/tanks/tanks' do
    @tanks = Tank.all
    @user = User.find(session[:user_id])
    erb :"tanks/tanks"
  end

  get '/tanks/addtank' do 
   @tanks = Tank.all
   puts @tanks
   puts "$$$$$$" 
   erb :"tanks/addtank"
  end
  
  post '/tanks/addtank' do 
   @tanks = Tank.all
    Tank.create(:name => params[:name])
   puts @tanks
    redirect to "/tanks/tanks"
  end
  
  get "/users/login" do
    erb :"users/login"
  end

  post "/users/login" do
    user = User.find_by(:username => params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/tanks/tanks"
      else
        redirect "/failure"
      end
    end

  get "/failure" do
    erb :failure
  end

  get "/logout" do
    session.clear
    redirect "/"
  end

end
