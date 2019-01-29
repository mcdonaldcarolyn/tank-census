class UsersController < ApplicationController
  
  
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