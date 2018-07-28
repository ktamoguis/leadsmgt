class SessionsController < ApplicationController

  def welcome
  end

  def new
    @agent = Agent.new
  end

  def create
    binding.pry
    @agent = Agent.find(params[:agent][:name])
    if @agent.authenticate(params[:agent][:password])
      set_session
    else
      redirect_to signin_path
    end
  end

  def destroy
    session.delete :agent_id
    redirect_to '/'
  end

  private

  def set_session
    session[:agent_id] = @agent.id
    redirect_to agent_path(@agent)
  end

end
