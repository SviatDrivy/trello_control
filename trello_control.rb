require "faraday"

response = Faraday.get("https://api.trello.com/1/boards/LFZoaH46/cards")

require "json"

cards = JSON.parse (response.body)

infos = []

cards.each do |cards_hash|
  card_name = cards_hash["name"]
  short_link = cards_hash["id"]
  infos += [short_link + " : " + card_name]
end

if ARGV[0] == "list"
 	puts infos
elsif ARGV[0] == "create"
	puts "new card created"
	require_relative "secrets"
	response = Faraday.post("https://api.trello.com/1/cards?", {"name" => ARGV[1], "desc" => ARGV[2], "idList" => "5bb39ee0029f335fb88aa2a9", "key" => API_KEY, "token" => API_TOKEN})
else 
	puts "error"
end
