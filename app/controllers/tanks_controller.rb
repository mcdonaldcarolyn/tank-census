
class TanksController < ApplicationController
  
  
  get '/tanks/list' do
    
    @tanks = Tank.all
    @user = User.find(session[:user_id])
    erb :"/tanks/list"
  end

  get '/tanks/addtank' do 
   erb :"tanks/addtank"
  end
  
  post '/tanks/addtank' do 
    @tank = Tank.create(:name => params[:name], :user_id => session[:user_id])
      if @tank.valid?
        redirect to "/tanks/list"
      else
        @errormsg = @tank.errors.messages
        erb :'tanks/addtank'
      end
  end

  get '/tanks/:id/edittank' do
    @tank = Tank.find(params[:id])
    if @tank.user_id != session[:user_id]
      @errormsg = "This tank does not belong to you, you can not edit it"
      erb :'tanks/edit'
    else
      erb :'tanks/edittank'
    end
  end
  
  patch '/tanks/:id' do 
    @tank = Tank.find(params[:id])
    @tank.name = params[:name]
    if @tank.save
        redirect to "/tanks/list"
    else
        @errormsg = @tank.errors.full_messages
        erb :'tanks/edittank'
    end
  end

  delete '/tanks/:id/delete' do
    @tank = Tank.delete(params[:id])
    redirect '/tanks/list'
  end

  
  

end