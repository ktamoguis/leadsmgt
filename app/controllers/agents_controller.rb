class AgentsController < ApplicationController

  def new
    @agent = Agent.new
  end

  def create
    #binding.pry
    @agent = Agent.create(agent_params)
    if !@agent.errors.empty?
      #binding.pry
      render :new
    else
      set_session
    end
  end

  def show
    @agent = Agent.find(params[:id])
    @total_leads = @agent.leads.count
    @total_go = @agent.leads.where(status: "Go").count
    @total_nogo = @agent.leads.where(status: "No Go").count
    @total_converted = @agent.leads.where(status: "Converted").count
    @total_booked = @agent.leads.sum(:booked_loans)
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
