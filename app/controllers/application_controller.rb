class ApplicationController < ActionController::Base


  def set_session
    session[:agent_id] = @agent.id
    redirect_to agent_path(@agent)
  end

  def logged_in?
    !!session[:agent_id]
  end

  def current_user
    Agent.find(session[:agent_id])
  end

  def agent_is_not_current_user?
    #binding.pry
    if !params[:agent_id].nil?
      Agent.find_by(id: params[:agent_id]) != current_user
    end
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

end
