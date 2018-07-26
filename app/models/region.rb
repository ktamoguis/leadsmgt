class Region < ApplicationRecord
  has_many :agents
  has_many :leads, through: :agents
  has_many :industries, through: :leads
end
