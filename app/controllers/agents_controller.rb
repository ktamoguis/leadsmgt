class AgentsController < ApplicationController

  def new
    control_check
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
    control_check
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
    control_check
    @agent = Agent.find(params[:id])
    @total_leads = @agent.leads.count
    @total_go = @agent.leads.where(status: "Go").count
    @total_nogo = @agent.leads.where(status: "No Go").count
    @total_converted = @agent.leads.where(status: "Converted").count
    @total_booked = @agent.leads.sum(:booked_loans)
  end

  def index
    control_check
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

  def log_in_check
    if !logged_in?
      not_logged_in_action
    end
  end

  def control_check
    if !logged_in?
      not_logged_in_action
    elsif agent_is_not_current_user?
      agent_not_current_user_action
    end
  end


  def logged_in?
    !!session[:agent_id]
  end

  def not_logged_in_action
    flash[:notice] = "Agent not logged in"
    redirect_to '/'
  end


  def agent_is_not_current_user?
    if params[:agent_id].nil?
    else
      Agent.find_by(id: params[:agent_id]) != current_user
    end
  end

  def agent_not_current_user_action
    flash[:notice] = "Lead does not belong to current agent"
    redirect_to agent_path(session[:agent_id])
  end


end
