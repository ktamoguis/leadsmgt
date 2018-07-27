class AddDefaultValueToRank < ActiveRecord::Migration[5.2]
  def change
    change_column :agents, :rank, :integer, default: 0
  end
end
