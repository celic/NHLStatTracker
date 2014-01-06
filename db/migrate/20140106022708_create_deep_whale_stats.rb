class CreateDeepWhaleStats < ActiveRecord::Migration
  def change
    create_table :deep_whale_stats do |t|
      t.integer :goals
      t.integer :assists
      t.integer :pims
      t.integer :toi
      t.integer :pm
      t.integer :sog
      t.timestamps
    end
  end
end
