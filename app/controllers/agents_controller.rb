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
    agent_check
    @agent = Agent.find_by(id: session[:agent_id])
    if @agent.manager
      @agents = Agent.where("region_id = ?", @agent.region_id)
    else
      redirect_to agent_path(@agent)
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

  def current_user
    Agent.find(session[:agent_id])
  end

  def agent_check
    if !logged_in?
      flash[:notice] = "Agent not logged in"
      redirect_to '/'
    elsif agent_is_not_current_user?
      flash[:notice] = "Agent is not current user or agent doesn't exist"
      redirect_to agent_path(session[:agent_id])
    end
  end

  def logged_in?
    !!session[:agent_id]
  end

  def agent_is_not_current_user?
    if !params[:id].nil?
      Agent.find_by(id: params[:id]) != current_user
    end
  end




end
