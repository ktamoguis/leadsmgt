class RegionsController < ApplicationController

  def show
    binding.pry
    @agent = Agent.find_by(id: session[:agent_id])
    @region = Region.find_by(id: params[:id])
    if params[:status].nil? || params[:status] == ""
      @leads = Lead.by_manager_region(@region.id)
    else
      @leads = Lead.by_region(@region.id, params[:status])
    end
  end

  def index
    binding.pry
    @agent = Agent.find_by(id: session[:agent_id])
    if @agent.manager
      @regions = Region.all
    else
      redirect_to agent_path(@agent)
    end
  end

end
