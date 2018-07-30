class LeadsController < ApplicationController

  def new
    binding.pry
    control_check
    @agent = current_user
    @lead = Lead.new
    @region = @agent.region
  end

  def create
    @lead = Lead.create(leads_params)
    binding.pry
    if @lead.errors.any?
      @region = current_user.region
      render :new
    else
      @lead.save
      redirect_to lead_path(@lead)
    end
  end

  def edit
    binding.pry
    control_check
    @lead = Lead.find_by(id: params[:id])
  end

  def update
    @lead = Lead.find(params[:id])
    @lead.update(leads_params)
    if @lead.errors.any?
      render :new
    else
      redirect_to lead_path(@lead)
    end
  end

  def show
    binding.pry
    control_check
    lead_exist_check(params[:id])
    @lead = Lead.find_by(id: params[:id])
    @agent = @lead.agent

  end

  def destroy
    binding.pry
    @lead = Lead.find(params[:id])
    @lead.destroy
    @agent = Agent.find(session[:agent_id])
    redirect_to agent_path(@agent)
  end

  def index
    binding.pry
    control_checks
    @agent = current_user
    if params[:status].nil? || params[:status] == ""
      @leads = @agent.leads
    else
      @leads = Lead.by_agent(@agent.id, params[:status])
    end
  end


  private
  def leads_params
    params.require(:lead).permit(:name, :status, :agent_id, :region_id, :booked_loans, :industry_id, industry_attributes:[:name])
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

  def lead_exist_check(lead_id)
    if !Lead.find_by(id: lead_id)
      flash[:notice] = "Lead doesn't exist"
      redirect_to agent_path(session[:agent_id])
    end
  end


  def logged_in?
    !!session[:agent_id]
  end

  def not_logged_in_action
    flash[:notice] = "Agent not logged in"
    redirect_to '/'
  end

  def lead_exists?(id)
    Lead.find_by(id: id)
  end

  def lead_not_exists_action
    flash[:notice] = "Lead doesn't exist"
    redirect_to agent_path(session[:agent_id])
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
