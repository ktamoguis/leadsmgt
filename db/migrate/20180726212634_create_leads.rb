class CreateLeads < ActiveRecord::Migration[5.2]
  def change
    create_table :leads do |t|
      t.string :name
      t.string :status
      t.integer :booked_loans
      t.integer :agent_id
      t.integer :industry_id

      t.timestamps
    end
  end
end
