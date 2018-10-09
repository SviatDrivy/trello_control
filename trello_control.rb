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
else 
	puts "error"
end