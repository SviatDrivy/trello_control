require "json"
require "faraday"

require_relative "trello_client"

API_KEY = ENV['API_KEY']
API_TOKEN = ENV['API_TOKEN']

class MyApp

  def call(env)
    trello_client = TrelloClient.new

    body = "<h1>My todo list</h1>"
    body += trello_client.list.gsub("\n", "<br>")
    [200, { "Content-Type" => "text/html" }, [body]]
  end

end

app = MyApp.new

run app
