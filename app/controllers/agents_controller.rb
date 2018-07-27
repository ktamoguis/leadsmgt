class AgentsController < ApplicationController

  def new
    @agent = Agent.new
  end

  def create
    binding.pry
    @agent = Agent.new(agent_params)
    @agent.save
    set_session
    binding.pry
    redirect_to agent_path(@agent)
  end

  def show
    @agent = Agent.find(params[:id])
  end


  private
  def agent_params
    params.require(:agent).permit(:name, :password, :manager)
  end

  def set_session
    session[:agent_id] = @agent.id
  end

end
