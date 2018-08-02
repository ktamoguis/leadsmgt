class IndustriesController < ApplicationController

  def show
    #binding.pry
    agent_check
    @agent = Agent.find_by(id: session[:agent_id])
    @industry = Industry.find_by(id: params[:id])
    if params[:status].nil? || params[:status] == ""
      @leads = Lead.by_manager_industry(@industry.id)
    else
      @leads = Lead.by_industry(@industry.id, params[:status])
    end
  end

  def index
    #binding.pry
    agent_check
    @agent = Agent.find_by(id: session[:agent_id])
    if @agent.manager
      @industries = Industry.all
      @total_leads = Industry.all_leadcount
      @total_go = Industry.by_status_leadcount("Go")
      @total_nogo = Industry.by_status_leadcount("No Go")
      @total_converted = Industry.by_status_leadcount("Converted")
      @total_booked = Industry.sum_bookedloans
    else
      redirect_to agent_path(@agent)
    end
  end


end
