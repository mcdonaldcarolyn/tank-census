
class TanksController < ApplicationController
  
  
  get '/tanks/list' do
    if logged_in? 
      @tanks = Tank.all
      @user = User.find(session[:user_id])
      redirect to '/tanks/list'
    else
      erb :'/welcome'  
    end
  end

  get '/tanks/add' do 
    if logged_in? && current_user
      erb :'tanks/add'
    else
      erb :'welcome'
    end
  end
  
  post '/tanks/add' do 
    if logged_in? && current_user
      @tank = Tank.create(:name => params[:name], :user_id => session[:user_id])
        if @tank.valid?
          redirect to '/tanks/list'
        else
          @errormsg = @tank.errors.full_messages
          erb :'tanks/add'
        end
    else   
      erb :'/welcome'
    end
  end

  get '/tanks/:id/edit' do
    if logged_in? && current_user
      @tank = Tank.find(params[:id])
        if @tank.user_id != session[:user_id]
          @errormsg = "This tank does not belong to you, you can not edit it"
          erb :'tanks/edit'
        else
          erb :'tanks/edit'
        end
    else 
      erb :'/welcome'
    end
  end
  
  patch '/tanks/:id' do 
    if logged_in? && current_user
      @tank = Tank.find(params[:id])
      @tank.name = params[:name]
        if @tank.save
          redirect to '/tanks/list'
        else
          @errormsg = @tank.errors.full_messages
          erb :'tanks/edit'
        end
    else
      erb :'/welcome'
    end
  end

  delete '/tanks/:id/delete' do
    if logged_in? && current_user
      @tank = Tank.delete(params[:id])
      redirect '/tanks/list'
    else
      erb :'/welcome'
    end
  end

  
  

end