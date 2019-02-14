
class TanksController < ApplicationController
  
  
  get '/tanks/list' do
    if logged_in? 
      @tanks = Tank.all
      @user = User.find(session[:user_id])
      erb  :'/tanks/list'
    else
      redirect '/'  
    end
  end

  get '/tanks/add' do 
    if logged_in? 
      erb :'tanks/add'
    else
      redirect '/'
    end
  end
  
  post '/tanks/add' do 
    if logged_in?
      @tank = Tank.new(:name => params[:name], :user_id => session[:user_id])
        if @tank.save
          redirect to '/tanks/list'
        else
          @errormsg = @tank.errors.full_messages
          erb :'tanks/add'
        end
    else   
      redirect '/'
    end
  end
  
  
    get '/tanks/:id/edit' do
    @tank = Tank.find(params[:id])
    if logged_in? && current_user == @tank.user
      erb :'tanks/edit'
    else 
      redirect '/'
    end
  end
  
  patch '/tanks/:id' do 
    if logged_in?
      @tank = Tank.find(params[:id])
      @tank.name = params[:name]
      if @tank.save
        redirect to '/tanks/list'
      else
        @errormsg = @tank.errors.full_messages
        erb :'tanks/list'
      end
    else
      erb :'/welcome'
    end
  end

  delete '/tanks/:id/delete' do
    if logged_in? 
      @tank = Tank.delete(params[:id])
      redirect '/tanks/list'
    else
      erb :'/welcome'
    end
  end

  
  

end