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
      @total_leads = Industry.joins(:leads).count
      @total_go = Industry.joins(:leads).where("status = ?","Go").count
      @total_nogo = Industry.joins(:leads).where("status = ?","No Go").count
      @total_converted = Industry.joins(:leads).where("status = ?","Converted").count
      @total_booked = Industry.joins(:leads).sum(:booked_loans)
    else
      redirect_to agent_path(@agent)
    end
  end


end
