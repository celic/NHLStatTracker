# Pulls stats daily and stores them in ActiveRecord

# Require
require 'rubygems'
require 'date'
require 'json'
require 'open-uri'
require 'nokogiri'

# Collect stats for games on this date
date = Date.today.prev_day

# Stat Variables with defaults of 0
points = Hash.new(0)
goals = Hash.new(0)
assists = Hash.new(0)

shots_faced = Hash.new(0)
saves_made = Hash.new(0)
svpct = Hash.new(0)

# Find and store game ids from date
game_ids = Array.new

# Open Game ID File
game_id_file = open("http://live.nhl.com/GameData/SeasonSchedule-20132014.json")
game_id_contents = JSON.parse(game_id_file.read)

game_id_contents.each do |game|
    
    # Get the date from the JSON
    game_date = Date.parse(game["est"].partition(" ")[0])
    
    # Store all game ids from the date
    if game_date === date
        game_ids << game["id"]
    end
    
end

# Gather data from game ids
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
  
    # Loop through all home players
    contents['rosters']['home']['skaters'].each do |player|
        number = player['num'].to_s
        name = names[0][number]
        goals[name] += player['g']
        assists[name] += player['a']
        points[name] += player['g'] + player['a']
    end
    
    # Loop through all away players
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
points.sort{|x, y| y[1] <=> x[1] }.each do |name, total|
    puts "#{name}: #{goals[name]}-#{assists[name]}-#{total}"
end