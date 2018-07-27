class SessionsController < ApplicationController

  def new
    @agents = Agents.all
  end

  def create
    @agent = Agent.find(params[:agent][:name])
    if @agent.authenticate(params[:agent][:password])
      set_session
    else
      redirect_to signin
    end
  end

  def destroy
  end

  private

  def set_session
    session[:agent_id] = @agent.id
    redirect_to agent_path(@agent)
  end

end
