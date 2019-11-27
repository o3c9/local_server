require 'sinatra'
require 'sinatra/json'
require 'open-uri'

dump =  ->(req) do
  data = JSON.parse req.body.read
  puts "=== json ==="
  puts data
  data
rescue
  nil
end

post '/' do
  data = dump.(request)
  if data
    if params.key?("confirmationToken")
      open(data["enableUrl"]).read
    end
    json result: "ok"
  else
    json result: "error"
  end
end

post '/recipes' do
  if dump.(request)
    json result: "ok"
  else
    json result: "error"
  end
end

get '/recipes' do
  json params
end
