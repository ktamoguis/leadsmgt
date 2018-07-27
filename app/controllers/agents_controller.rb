class AgentsController < ApplicationController

  def new
    @agent = Agent.new
  end

  def create
    binding.pry
    @agent = Agent.new(agent_params)
    @agent.save
    set_session

    @user = User.new(user_params)
      @user.save
      set_session
  end

  private
  def agent_params
    params.require(:user).permit(:name, :password, :admin)
  end

  def set_session
    session[:agent_id] = @agent.id
    redirect_to agent_path(@agent)
  end

end
