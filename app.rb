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

delete "/lists/:id" do
  List.find(params["id"]).destroy
  redirect "/lists"
end

post "/lists" do
  @list = List.new(params["list"])
  if @list.save
    redirect "/lists"
  else
    erb :"lists/new.html", layout: :"layout/application.html"
  end
end

get "/lists/:id/edit" do
  @list = List.find(params["id"])
  erb :"lists/edit.html", layout: :"layout/application.html"
end

patch "/lists/:id/edit" do
  @list = List.find(params["id"])
  @list.update(params["list"])
  if @list.save
    redirect "/lists"
  else
    erb :"lists/edit.html", layout: :"layout/application.html"
  end
end

get "/lists/:id/items/new" do
  @list = List.find(params["id"])
  @item = @list.items.build
  erb :"/items/new.html", layout: :"layout/application.html"
end

post "/items" do
  @item = Item.new(params["item"])
  if @item.save
    redirect "/lists/#{@item.list_id}"
  else
    erb :"items/new.html", layout: :"layout/application.html"
  end
end

delete "/items/:id" do
  @item = Item.find(params["id"])
  @list = List.find(@item.list_id)
  @item.destroy
  redirect "/lists/#{@list.id}"
end

get "/items/:id/edit" do
  @item = Item.find(params["id"])
  erb :"items/edit.html", layout: :"layout/application.html"
end

patch "/items/:id/edit" do
  @item = Item.find(params["id"])
  @list = List.find(@item.list_id)
  @item.update(params["item"])
  if @item.save
    redirect "/lists/#{@list.id}"
  else
    erb :"items/edit.html", layout: :"layout/application.html"
  end
end
