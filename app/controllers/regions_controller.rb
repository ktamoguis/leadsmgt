class RegionsController < ApplicationController

  def show
    binding.pry
    @region = Region.find_by(id: params[:id])
    @leads = @region.leads
  end

end
