class LeadsController < ApplicationController

  def new
    @agent = Agent.find(session[:agent_id])
    @lead = Lead.new
  end

  def create
    binding.pry
  end
end
