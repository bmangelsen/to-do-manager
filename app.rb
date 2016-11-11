require "sinatra"
require "./db/connection"

set :method_override, true

get "/" do
  erb :"home/index.html"
end

get "/lists" do
  @lists = List.all
  erb :"lists/index.html", layout: :"layout/application.html"
end

get "/lists/new" do
  @list = List.new
  erb :"lists/new.html", layout: :"layout/application.html"
end

get "/lists/:id" do
  @list = List.find(params["id"])
  erb :"items/index.html", layout: :"layout/application.html"
end

post "/lists" do
  @list = List.new(params["list"])
  if @list.save
    redirect "/lists"
  else
    erb :"lists/new.html", layout: :"layout/application.html"
  end
end
