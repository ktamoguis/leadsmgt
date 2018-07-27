class AgentsController < ApplicationController

  def new
    @agent = Agent.new
  end

  def create
    binding.pry
    @region = Region.find_by(id: params[:agent][:region_id])
    @agent = Agent.new(agent_params)
    @agent.region = @region
    @agent.save
    set_session
  end

  def show
    @agent = Agent.find(params[:id])
  end


  private
  def agent_params
    params.require(:agent).permit(:name, :password, :manager, :region_id)
  end

  def set_session
    session[:agent_id] = @agent.id
    redirect_to agent_path(@agent)
  end

end
