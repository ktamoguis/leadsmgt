class LeadsController < ApplicationController

  def new
    @agent = current_user
    @lead = Lead.new
  end

  def create
    binding.pry
    @lead = Lead.new(leads_params)
    @lead.agent = current_user
    binding.pry
    @lead.save
    binding.pry

    redirect_to agent_path(current_user)
  end

  def edit
    @lead = Lead.find_by(id: params[:id])
  end


  private
  def leads_params
    params.require(:lead).permit(:name, :status, :industry_id, industry_attributes:[:name])
  end

  def current_user
    Agent.find(session[:agent_id])
  end
end
