# Pulls stats daily and stores them in ActiveRecord

# Game ID's: http://live.nhl.com/GameData/SeasonSchedule-20132014.json
# Game Stats: http://live.nhl.com/GameData/20132014/id/PlayByPlay.json
# New Game Stats: http://live.nhl.com/GameData/20132014/id/gc/gcbx.jsonp

# Require
require 'rubygems'
require 'json'
require 'open-uri'
require 'nokogiri'

# 2013020538

# Static Game ID
game_ids = Array(2013020500..2013020538)

# Important Variables with defaults of 0
points = Hash.new(0)
goals = Hash.new(0)
assists = Hash.new(0)

game_ids.each do |game_id|
    puts "Finding Game ID: #{game_id}"
    
    # Open Game File
    file = open("http://live.nhl.com/GameData/20132014/#{game_id}/gc/gcbx.jsonp")
    contents = file.read
    
    # Open Game ID File
    game_id_file = open("http://live.nhl.com/GameData/SeasonSchedule-20132014.json")
    game_id_contents = game_id_file.read
    
    # Remove GCBX.load
    contents = contents[10..-3]
    
    # Parse JSON
    contents = JSON.parse(contents)
    game_id_contents = JSON.parse(game_id_contents)
    
    # Parse names from roster number
    game_id_contents.each do |game|
        if game["id"] == game_id
            @home_abrv = game["h"]
            @away_abrv = game["a"]
            break
        end
    end
    
    # Set rosters
    home_roster = Nokogiri::HTML(open("http://www.hockey-reference.com/teams/#{@home_abrv}/2014.html"))
    away_roster = Nokogiri::HTML(open("http://www.hockey-reference.com/teams/#{@away_abrv}/2014.html"))
    rosters = Array[home_roster, away_roster]
    
    # Player names hash
    home_names = Hash.new
    away_names = Hash.new
    names = Array[home_names, away_names]
    
    # Find home and away names via roster number
    rosters.each.with_index do |roster, index|
        roster.css('table#roster > tbody > tr').each do |row|
            number = 0
            row.children().first(3).each do |td|
                if number == 0
                    number = td.content.to_i
                else
                    names[index][number.to_s] = td.content
                end
            end
        end
    end
    
    # Print out all names found
    #(0..1).each do |index|
    #        names[index].each do |number, name|
    #            puts number + " " + name
    #    end
    #end
  
    # Loop through all players
    contents['rosters']['home']['skaters'].each do |player|
        number = player['num'].to_s
        name = names[0][number]
        goals[name] += player['g']
        assists[name] += player['a']
        points[name] += player['g'] + player['a']
    end
    
    contents['rosters']['away']['skaters'].each do |player|
        number = player['num'].to_s
        name = names[1][number]
        goals[name] += player['g']
        assists[name] += player['a']
        points[name] += player['g'] + player['a']
    end
end

# Output
puts 'Point totals:'
points.sort{|x, y| y[1] <=> x[1] }.first(30).each do |name, total|
        puts "#{name}: #{total}"
end