
class TanksController < ApplicationController
  
  
  get '/tanks/tanks' do
    
    @tanks = Tank.all
    @user = User.find(session[:user_id])
    erb :"tanks/tanks"
  end

  get '/tanks/addtank' do 
   erb :"tanks/addtank"
  end
  
  post '/tanks/addtank' do 
    @tank = Tank.create(:name => params[:name], :user_id => session[:user_id])
      if @tank.valid?
        redirect to "/tanks/tanks"
      else
        @errormsg = @tank.errors.messages
        erb :'tanks/addtank'
      end
  end
  
  
  
  get '/tanks/:id/edittank' do
    @tank = Tank.find(params[:id])
    erb :'/tanks/edittank'
  end
  
  patch '/tanks/:id' do 
    @tank = Tank.find(params[:id])
    @tank.name = params[:name]
    if @tank.save
        redirect to "/tanks/tanks"
    else
        @errormsg = @tank.errors.messages
        erb :'tanks/edittank'
    end
  end

  delete '/tanks/:id' do
    @tank = Tank.delete(params[:id])
    redirect '/tanks/tanks'
  end

  
  

end