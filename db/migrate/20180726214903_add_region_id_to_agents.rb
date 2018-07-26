class AddRegionIdToAgents < ActiveRecord::Migration[5.2]
  def change
    add_column :agents, :region_id, :integer
  end
end
