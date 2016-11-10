require "pry"
require "active_record"
require "./item"
require "./list"

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: "db/dev.sqlite3"
)
