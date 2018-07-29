class IndustriesController < ApplicationController

  def show
    binding.pry
    @agent = Agent.find_by(id: session[:agent_id])
    if @agent.manager
      @industry = Industry.find_by(id: params[:id])
      if params[:status].nil? || params[:status] == ""
        @leads = Lead.by_manager_industry(@industry.id)
      else
        @leads = Lead.by_industry(@industry.id, params[:status])
      end
    else
      redirect_to agent_path(@agent)
    end
  end

end
