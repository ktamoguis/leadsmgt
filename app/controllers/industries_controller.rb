class IndustriesController < ApplicationController

  def show
    @industry = Industry.find(id: params[:id])
    @leads = @industry.leads
  end

end
