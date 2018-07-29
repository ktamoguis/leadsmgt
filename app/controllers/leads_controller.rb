class LeadsController < ApplicationController

  def new
    @agent = current_user
    @lead = Lead.new
  end

  def create
    @lead = Lead.create(leads_params)
    #@lead.agent = current_user
    binding.pry
    if @lead.errors.any?
      render :new
    else
      @lead.save
      redirect_to agent_path(current_user)
    end
  end

  def edit
    @lead = Lead.find_by(id: params[:id])
  end

  def update
    @lead = Lead.find(params[:id])
    binding.pry
    @lead.update(leads_params)
    if @lead.errors.any?
      binding.pry
      render :new
    else
      redirect_to agent_path(current_user)
    end
  end

  def show
    @lead = Lead.find(params[:id])
    #redirect_to agent_path(current_user)
  end

  def index
    binding.pry
    @agent = current_user
    if params[:status].nil? || params[:status] == ""
      @leads = @agent.leads
    else
      @leads = Lead.leads_by_agent(@agent.id, params[:status])
    end
  end


  private
  def leads_params
    params.require(:lead).permit(:name, :status, :agent_id, :booked_loans, :industry_id, industry_attributes:[:name])
  end

  def current_user
    Agent.find(session[:agent_id])
  end
end
