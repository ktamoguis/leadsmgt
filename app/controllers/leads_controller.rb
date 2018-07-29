class LeadsController < ApplicationController

  def new
    binding.pry
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
    @lead = Lead.find(params[:id])
    @agent = current_user
  end

  def index
    @agent = current_user
    if params[:status].nil? || params[:status] == ""
      @leads = @agent.leads
    else
      @leads = Lead.leads_by_agent(@agent.id, params[:status])
    end
  end


  private
  def leads_params
    params.require(:lead).permit(:name, :status, :agent_id, :region_id, :booked_loans, :industry_id, industry_attributes:[:name])
  end

  def current_user
    Agent.find(session[:agent_id])
  end
end
