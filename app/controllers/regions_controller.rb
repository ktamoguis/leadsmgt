class RegionsController < ApplicationController

  def show
    #binding.pry
    control_check
    @agent = Agent.find_by(id: session[:agent_id])
    @region = Region.find_by(id: params[:id])
    if params[:status].nil? || params[:status] == ""
      @leads = Lead.by_manager_region(@region.id)
    else
      @leads = Lead.by_region(@region.id, params[:status])
    end
  end

  def index
    #binding.pry
    control_check
    @agent = Agent.find_by(id: session[:agent_id])
    if @agent.manager
      @regions = Region.all
    else
      redirect_to agent_path(@agent)
    end
  end

  private

  def current_user
    Agent.find(session[:agent_id])
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
