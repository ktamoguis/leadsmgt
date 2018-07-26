class AddDefaultVlaueToManager < ActiveRecord::Migration[5.2]
  def change
    change_column :agents, :manager, :boolean, default: false
  end
end
