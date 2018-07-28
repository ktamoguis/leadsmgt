class AgentsController < ApplicationController

  def new
    @agent = Agent.new
  end

  def create
    binding.pry
    @agent = Agent.create(agent_params)
    binding.pry
    #@agent.save
    set_session
  end

  def show
    @agent = Agent.find(params[:id])
  end


  private
  def agent_params
    params.require(:agent).permit(:name, :password, :manager, :region_id, region_attributes:[:name])
  end

  def set_session
    session[:agent_id] = @agent.id
    redirect_to agent_path(@agent)
  end

end
