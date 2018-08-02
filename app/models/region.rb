class Region < ApplicationRecord
  has_many :agents
  has_many :leads, through: :agents
  has_many :industries, through: :leads
  validates :name, uniqueness: true
  validates :name, presence: true

  def self.by_status_leadcount(status)
    self.joins(:leads).where("status = ?",status).count
  end

  def self.all_leadcount
    self.joins(:leads).count
  end

  def self.sum_bookedloans
    self.joins(:leads).sum(:booked_loans)
  end


end
