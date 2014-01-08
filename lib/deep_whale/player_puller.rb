# Pulls player info and stores them in ActiveRecord

# Require
require 'rubygems'
require 'json'
require 'active_record'
require 'open-uri'
require 'nokogiri'

module DeepWhale
	game_ids = Array(2013020500..2013020536)
	abvs = Array.new

	# Open Game ID File
	game_id_file = open("http://live.nhl.com/GameData/SeasonSchedule-20132014.json")
	game_id_contents = game_id_file.read
	game_id_contents = JSON.parse(game_id_contents)

	names = Hash.new

	ActiveRecord::Base.establish_connection(
		adapter: "sqlite3",
		database: "../../test/dummy/db/development.sqlite3"
	)

	game_ids.each do |game_id|

		# Parse names from roster number
		game_id_contents.each do |game|
		    if game["id"] == game_id
		        @home_abrv = game["h"]
		        @away_abrv = game["a"]
		        break
		    end
		end
		
		if !(abvs.include?(@home_abrv)) && !(abvs.include?(@away_abrv))

			# Set rosters
			home_roster = Nokogiri::HTML(open("http://www.hockey-reference.com/teams/#{@home_abrv}/2014.html")) unless abvs.include?(@home_abrv)
			away_roster = Nokogiri::HTML(open("http://www.hockey-reference.com/teams/#{@away_abrv}/2014.html")) unless abvs.include?(@away_abvr)
			rosters = Array[home_roster, away_roster]

			abvs << @home_abrv unless home_roster.nil?
			abvs << @away_abrv unless away_roster.nil?

			names[@home_abrv] = Hash.new unless home_roster.nil?
			names[@away_abrv] = Hash.new unless away_roster.nil?

			# Find home and away names via roster number
			rosters.each.with_index do |roster, index|
				if !roster.nil?
					roster.css('table#roster > tbody > tr').each do |row|
						number = 0
						row.children().first(3).each do |td|
							if number == 0
								number = td.content.to_i
							else
								names[index == -0 ? @home_abrv : @away_abrv][number.to_s] = td.content
							end
						end
					end
				end
			end
		end
	end

	# Output
	names.each do |team, roster|
		roster.each do |number, name|
			team_id = ActiveRecord::Base.connection.execute("SELECT id FROM deep_whale_teams WHERE abbreviation=\"#{team}\"")
			ActiveRecord::Base.connection.execute("INSERT INTO deep_whale_players (name, jersey, team_id) VALUES (\"#{name}\", #{number}, #{team_id.first['id']})")
		end
	end
end