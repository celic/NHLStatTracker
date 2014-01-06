class CreateDeepWhaleTeams < ActiveRecord::Migration
  def change
    create_table :deep_whale_teams do |t|
      t.string :name
      t.string :abbreviation
      t.timestamps
    end
  end
end
