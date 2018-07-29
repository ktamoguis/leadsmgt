class AddRegionIdToLeads < ActiveRecord::Migration[5.2]
  def change
    add_column :leads, :region_id, :integer
  end
end
