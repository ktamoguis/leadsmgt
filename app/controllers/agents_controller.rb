class AgentsController < ApplicationController

  def new
    @agent = Agent.new
  end

  def create
    binding.pry
    #if params[:agent][:region_attributes][:name].nil?
    #  @region = Region.find_by(id: params[:agent][:region_id])
    #else
    #  @region = Region.create(params[:agent][:region_attributes][:name])
    #end

    @agent = Agent.create(agent_params)
    binding.pry
    #@agent.region = @region
    @agent.save
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
