class CreateDeepWhaleStats < ActiveRecord::Migration
  def change
    create_table :deep_whale_stats do |t|

      t.timestamps
    end
  end
end
