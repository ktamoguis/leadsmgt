class Agent < ApplicationRecord
  belongs_to :region
  has_many :leads
  has_many :industries, through: :leads
end
