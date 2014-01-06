class CreateDeepWhaleGames < ActiveRecord::Migration
  def change
    create_table :deep_whale_games do |t|
      t.integer :home_id
      t.integer :away_id
      t.datetime :game_time
      t.integer :json_id
      t.timestamps
    end
  end
end
