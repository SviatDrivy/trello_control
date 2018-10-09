require "json"
require "faraday"

require_relative "secrets"
require_relative "trello_client"

trello_client = TrelloClient.new

if ARGV[0] == "list"
	puts trello_client.list
elsif ARGV[0] == "create"
	puts trello_client.create(ARGV[1], ARGV[2])
elsif ARGV[0] == "delete"
    puts trello_client.delete(ARGV[1])
else 
	puts "error"
end
