
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
    @tank = Tank.create(:name => params[:name])
   if @tank.valid?
    @errormsg = @tank.errors.messages
    erb :'tanks/addtank'
   else
    redirect to "/tanks/tanks"
   end
  end
  
  
  
  get '/tanks/:id/edittank' do
  
    @tank = Tank.find(params[:id])
    erb :'/tanks/edittank'
  end
  
  post '/tanks/:id' do 
    puts "$$$^"
   @tank = Tank.find(params[:id])
   @tank.name = params[:name]
   @tank.save
    redirect to "/tanks/tanks"
  end

  delete '/tanks/:id' do
    @tank = Tank.delete(params[:id])
    redirect '/tanks/tanks'
  end

  
  

end