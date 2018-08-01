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

  def edit
    agent_check
    @agent = Agent.find(params[:id])
  end

  def update
    @agent = Agent.find(params[:id])
    @agent.update(agent_params)
    if @agent.errors.any?
      render :edit
    else
      redirect_to agent_path(@agent)
    end
  end

  def show
    agent_check
    @agent = current_user
    @total_leads = @agent.leads.count
    @total_go = @agent.leads.where(status: "Go").count
    @total_nogo = @agent.leads.where(status: "No Go").count
    @total_converted = @agent.leads.where(status: "Converted").count
    @total_booked = @agent.leads.sum(:booked_loans)
  end

  def index
    #binding.pry
    agent_check
    @agent = Agent.find_by(id: session[:agent_id])
    if @agent.manager
      @agents = Agent.where("region_id = ?", @agent.region_id)
      @total_leads = Lead.where("region_id = ?", @agent.region_id).count
      @total_go = Lead.where("region_id = ?", @agent.region_id).where("status = ?","Go").count
      @total_nogo = Lead.where("region_id = ?", @agent.region_id).where("status = ?","No Go").count
      @total_converted = Lead.where("region_id = ?", @agent.region_id).where("status = ?","Converted").count
      @total_booked = Lead.where("region_id = ?", @agent.region_id).sum(:booked_loans)
    else
      redirect_to agent_path(@agent)
    end
  end


  private
  def agent_params
    params.require(:agent).permit(:name, :password, :manager, :region_id, region_attributes:[:name])
  end


end
