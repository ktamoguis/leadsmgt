class Industry < ApplicationRecord
  has_many :leads
  has_many :agents, through: :leads
end
