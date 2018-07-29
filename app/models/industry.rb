class Industry < ApplicationRecord
  has_many :leads
  has_many :agents, through: :leads
  validates :name, uniqueness: true
  validates :name, presence: true
end
