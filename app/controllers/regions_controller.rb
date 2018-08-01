class RegionsController < ApplicationController

  def show
    #binding.pry
    agent_check
    @agent = Agent.find_by(id: session[:agent_id])
    @region = Region.find_by(id: params[:id])
    if params[:status].nil? || params[:status] == ""
      @leads = Lead.by_manager_region(@region.id)
    else
      @leads = Lead.by_region(@region.id, params[:status])
    end
  end

  def index
    #binding.pry
    agent_check
    @agent = Agent.find_by(id: session[:agent_id])
    if @agent.manager
      @regions = Region.all
      @total_leads = Region.joins(:leads).count
      @total_go = Region.joins(:leads).where("status = ?","Go").count
      @total_nogo = Region.joins(:leads).where("status = ?","No Go").count
      @total_converted = Region.joins(:leads).where("status = ?","Converted").count
      @total_booked = Region.joins(:leads).sum(:booked_loans)
    else
      redirect_to agent_path(@agent)
    end
  end


end
