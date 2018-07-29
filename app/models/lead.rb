class Lead < ApplicationRecord
  belongs_to :agent
  belongs_to :industry
  accepts_nested_attributes_for :industry, reject_if: proc { |attributes| attributes['name'].blank? }
  validates :name, presence: true
  validates :booked_loans, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def self.leads_by_agent(agent_id, status)
    self.where("status = ?", status).where("agent_id = ?", agent_id)
  end



end
