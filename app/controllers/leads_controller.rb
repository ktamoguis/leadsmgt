class LeadsController < ApplicationController

  def new
    @agent = current_user
    @lead = Lead.new
  end

  def create
    #binding.pry
    @lead = Lead.new(leads_params)
    @lead.agent = current_user
    #binding.pry
    @lead.save
    #binding.pry

    redirect_to agent_path(current_user)
  end

  def edit
    binding.pry
    @lead = Lead.find_by(id: params[:id])
  end

  def update
    binding.pry
    @lead = Lead.find(params[:id])
    binding.pry
    @lead.update(leads_params)
    binding.pry

    redirect_to agent_path(current_user)
  end


  private
  def leads_params
    params.require(:lead).permit(:name, :status, :booked_loans, :industry_id, industry_attributes:[:name])
  end

  def current_user
    Agent.find(session[:agent_id])
  end
end
