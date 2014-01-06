class CreateDeepWhaleTeams < ActiveRecord::Migration
  def change
    create_table :deep_whale_teams do |t|

      t.timestamps
    end
  end
end
