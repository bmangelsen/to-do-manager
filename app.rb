require "sinatra"
require "./db/connection"

set :method_override, true

get "/" do
  erb :"home/index.html", layout: :"layout/application.html"
end
