# Pulls team info and stores them in ActiveRecord

# Require
require 'rubygems'
require 'active_record'
require 'sqlite3'
require 'json'
require 'open-uri'
require 'nokogiri'

module DeepWhale
	game_ids = Array(2013020500..2013020538)
	teams = Hash.new

	ActiveRecord::Base.establish_connection(
		adapter: "sqlite3",
		database: "../../test/dummy/db/development.sqlite3"
	)

	# Open Game ID File
	game_id_file = open("http://live.nhl.com/GameData/SeasonSchedule-20132014.json")
	game_id_contents = game_id_file.read
	game_id_contents = JSON.parse(game_id_contents)

	game_ids.each do |game_id|

		# Open Game File
	    file = open("http://live.nhl.com/GameData/20132014/#{game_id}/PlayByPlay.json")
	    contents = file.read
	    contents = JSON.parse(contents)

		game_id_contents.each do |game|
		    if game["id"] == game_id
		        @home_abrv = game["h"]
		        @away_abrv = game["a"]
		        break
		    end
		end

		teams[@home_abrv] = contents['data']['game']['hometeamname']
		teams[@away_abrv] = contents['data']['game']['awayteamname']
	end

	# Output
	teams.each do |abv, name|
		ActiveRecord::Base.connection.execute("INSERT INTO deep_whale_teams (name, abbreviation) VALUES (\"#{name}\", \"#{abv}\")")
		# DeepWhale::Team.create!(:name => name, :abbreviation => abv)
	end
end