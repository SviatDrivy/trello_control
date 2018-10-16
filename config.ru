require "json"
require "faraday"

require_relative "trello_client"

API_KEY = ENV['API_KEY']
API_TOKEN = ENV['API_TOKEN']

class MyApp

  def call(env)
    trello_client = TrelloClient.new

    body = "<h1>My todo list</h1>"

    if env["PATH_INFO"] == "/create"
      req = Rack::Request.new(env)

      puts req.params
      trello_client.create(req.params["card_name"], '')

      [302, { "Content-Type" => "text/html", "location" => '/' }, []]
    else
      body += trello_client.list.gsub("\n", "<br>")

      body += '<form action="/create" method="post">' +
        '<label for="card_name">Create a new card: </label>' +
        '<input name="card_name">' +
        '<input type="submit">' +
        '</form>'

      [200, { "Content-Type" => "text/html" }, [body]]
    end

  end

end

app = MyApp.new

run app
