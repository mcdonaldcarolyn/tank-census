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
      user = User.new(:username => username, :password => password)
      user.save
      redirect "/login"
    end
  end

  get '/tanks' do
    @user = User.find(session[:user_id])
    erb :tanks
  end


  get "/login" do
    erb :login
  end

  post "/login" do
    user = User.find_by(:username => params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect "/tanks"
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

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end
