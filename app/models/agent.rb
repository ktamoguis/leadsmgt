class Agent < ApplicationRecord
  has_secure_password
  belongs_to :region
  has_many :leads
  has_many :industries, through: :leads
end
