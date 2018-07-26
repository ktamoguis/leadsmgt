class Lead < ApplicationRecord
  belongs_to :agent
  belongs_to :industry
end
