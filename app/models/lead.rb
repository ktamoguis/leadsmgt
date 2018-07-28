class Lead < ApplicationRecord
  belongs_to :agent
  belongs_to :industry
  accepts_nested_attributes_for :industry, reject_if: proc { |attributes| attributes['name'].blank? }

  def self.converted
    self.where("status = converted")
  end

  def self.active
    self.where("status = Go")
  end

end
