class Lead < ApplicationRecord
  belongs_to :agent
  belongs_to :industry
  belongs_to :region
  accepts_nested_attributes_for :industry, reject_if: proc { |attributes| attributes['name'].blank? }
  validates :name, presence: true
  validates :booked_loans, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def self.by_agent(agent_id, status)
    self.where("status = ?", status).where("agent_id = ?", agent_id)
  end

  def self.by_region(region_id, status)
    self.where("status = ?", status).where("region_id = ?", region_id)
  end

  def self.by_industry(industry_id, status)
    self.where("status = ?", status).where("industry_id = ?", industry_id)
  end

  def self.by_manager_region(region_id)
    self.where("region_id = ?", region_id)
  end

  def self.by_manager_industry(industry_id)
    self.where("industry_id = ?", industry_id)
  end


end
