class ApplicationController < ActionController::Base

  def logged_in?
    !!session[:agent_id]
  end

  def not_logged_in_action
    flash[:notice] = "Agent not logged in"
    redirect to '/'
  end

end
