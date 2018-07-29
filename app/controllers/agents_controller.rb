class AgentsController < ApplicationController

  def new
    @agent = Agent.new
  end

  def create
    binding.pry
    @agent = Agent.create(agent_params)
    if !@agent.errors.empty?
      binding.pry
      render :new
    else
      set_session
    end
  end

  def show
    binding.pry
    @agent = Agent.find(params[:id])
    if params[:status].nil? || params[:status] == ""
      @leads = @agent.leads
    else
      @leads = Lead.leads_by_agent(@agent.id, params[:status])
    end
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
