class CreateDeepWhaleGames < ActiveRecord::Migration
  def change
    create_table :deep_whale_games do |t|

      t.timestamps
    end
  end
end
