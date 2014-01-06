class CreateDeepWhalePlayers < ActiveRecord::Migration
  def change
    create_table :deep_whale_players do |t|

      t.timestamps
    end
  end
end
