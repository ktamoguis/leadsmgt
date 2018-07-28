class Agent < ApplicationRecord
  has_secure_password
  belongs_to :region, optional: true
  has_many :leads
  has_many :industries, through: :leads
  accepts_nested_attributes_for :region, reject_if: proc { |attributes| attributes['name'].blank? }

end
