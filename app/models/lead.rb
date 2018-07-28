class Lead < ApplicationRecord
  belongs_to :agent
  belongs_to :industry
  accepts_nested_attributes_for :industry, reject_if: proc { |attributes| attributes['name'].blank? }

  def self.convertedleads_by_agent(agent_id)
    binding.pry
    self.where("status = ?", "Converted").where("agent_id = ?", agent_id)
  end

  def self.activeleads_by_agent(agent_id)
    self.where("status = ?", "Go").where("agent_id= ?", agent_id)
  end


end
