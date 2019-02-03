class UsersController < ApplicationController
  
  
  get '/users/signup' do
    erb :'users/signup'
  end

  post '/users/signup' do
    username = params[:username]
    password = params[:password]
    if !username || username.length == 0 || !password || password.length == 0
      @errormsg = "Please enter a username and/or password"
      redirect '/failure'
    else 
      @user = User.create(:username => params[:username], :password => params[:password])
       if @user.valid?
        #@user.save
        redirect '/tanks/list'
       else
        @errormsg = @user.errors.messages
        redirect '/failure'
       end
    end
  end

  get '/users/login' do
    erb :'users/login'
  end

  post '/users/login' do
    user = User.find_by(:username => params[:username])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect '/tanks/list'
      else
        redirect '/welcome'
      end
    end

  get "/failure" do
    erb :failure
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

end