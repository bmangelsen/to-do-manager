require "pry"
require "active_record"
require "./item"
require "./list"
require "./db/migrations/create_items_table"
require "./db/migrations/create_lists_table"

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: "db/dev.sqlite3"
)
