class SessionsController < ApplicationController

  def welcome
  end

  def new
    @agent = Agent.new
  end

  def create
    @agent = Agent.find(params[:agent][:name])
    if @agent.authenticate(params[:agent][:password])
      set_session
    else
      redirect_to signin_path
    end
  end

  def create_with_facebook
    #binding.pry
    @agent = Agent.find_or_create_by(name: auth['name']) do |u|
      u.name = auth['info']['name']
      u.region = Region.all.first
      u.password = auth['info']['name']
    end
    @agent.save
    #binding.pry

    set_session

  end

  def destroy
    #binding.pry
    session.delete :agent_id
    redirect_to '/'
  end


  private

  def auth
    request.env['omniauth.auth']
  end

end
