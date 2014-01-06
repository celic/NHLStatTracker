class CreateDeepWhalePlayers < ActiveRecord::Migration
  def change
    create_table :deep_whale_players do |t|
      t.string :name
      t.integer :jersey
      t.integer :team_id
      t.timestamps
    end
  end
end
