class TrelloClient

	def list
		response = Faraday.get("https://api.trello.com/1/boards/LFZoaH46/cards")

		cards = JSON.parse (response.body)

		infos = []

		cards.each do |cards_hash|
		  card_name = cards_hash["name"]
		  short_link = cards_hash["id"]
		  infos += [short_link + " : " + card_name]
		end

	 	infos.join("\n")
	end

	def create(name, description)
		Faraday.post(
			"https://api.trello.com/1/cards?",
			{ 
				"name" => name,
				"desc" => description,
				"idList" => "5bb39ee0029f335fb88aa2a9",
				"key" => API_KEY,
				"token" => API_TOKEN
			}
		)
	    "new card created"
	end

	def delete(card_id)
		response = Faraday.delete(
			"https://api.trello.com/1/cards/" + card_id,
			{
				"key" => API_KEY,
				"token" => API_TOKEN
			}
		)

		if response.status.between?(200, 299)
		    "Card " + card_id + " deleted"
		else
			"We couldn't delete this card. Are you sure you got the right id?" + list
		end
	end
end