class LeadsController < ApplicationController

  def new
    #binding.pry
    agent_check
    @agent = current_user
    @lead = Lead.new
    @region = @agent.region
    #redirect_to new_agent_lead_path(@agent)
  end

  def create
    @lead = Lead.create(leads_params)
    #binding.pry
    if @lead.errors.any?
      @region = current_user.region
      render :new
    else
      @lead.save
      redirect_to lead_path(@lead)
    end
  end

  def edit
    #binding.pry
    control_check
    @lead = Lead.find_by(id: params[:id])
  end

  def update
    @lead = Lead.find(params[:id])
    @lead.update(leads_params)
    if @lead.errors.any?
      render :edit
    else
      redirect_to lead_path(@lead)
    end
  end

  def show
    #binding.pry
    control_check
    if Lead.find_by(id: params[:id])
      @lead = Lead.find_by(id: params[:id])
      @agent = @lead.agent
    end

  end

  def destroy
    #binding.pry
    @lead = Lead.find(params[:id])
    @lead.destroy
    @agent = Agent.find(session[:agent_id])
    redirect_to agent_path(@agent)
  end

  def index
    #binding.pry
    agent_check
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

  def control_check
    if !logged_in?
      flash[:notice] = "Agent not logged in"
      redirect_to '/'
    elsif !lead_exists?
      flash[:notice] = "Lead doesn't exist"
      redirect_to agent_path(session[:agent_id])
    elsif agent_is_not_current_user?
      flash[:notice] = "Agent is not current user or agent doesn't exist"
      redirect_to agent_path(session[:agent_id])
    elsif lead_does_not_belong_to_agent?
      flash[:notice] = "Lead does not belong to current agent"
      redirect_to agent_path(session[:agent_id])
    end
  end

  def lead_exists?
    #binding.pry
    if !params[:id].nil?
      Lead.find_by(id: params[:id]) != nil
    end
  end

  def agent_is_not_current_user?
    if !params[:agent_id].nil?
      Agent.find_by(id: params[:agent_id]) != current_user
    end
  end

  def lead_does_not_belong_to_agent?
    if !params[:id].nil? && Lead.find_by(id: params[:id])
      Lead.find_by(id: params[:id]).agent != current_user
    end
  end


end
