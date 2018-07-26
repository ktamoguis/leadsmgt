class CreateAgents < ActiveRecord::Migration[5.2]
  def change
    create_table :agents do |t|
      t.string :name
      t.string :password_digest
      t.boolean :manager
      t.integer :rank

      t.timestamps
    end
  end
end
