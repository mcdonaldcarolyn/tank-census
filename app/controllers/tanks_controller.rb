
class TanksController < ApplicationController
  
  
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