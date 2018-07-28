class Lead < ApplicationRecord
  belongs_to :agent
  belongs_to :industry

  def self.converted
    self.where("status = converted")
  end

  def self.active
    self.where("status = Go")
  end

  


end
