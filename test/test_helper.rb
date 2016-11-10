require "minitest/autorun"
require "minitest/pride"
require "active_record"
require "pry"

ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: "db/test.sqlite3"
)

require "./item"
require "./list"
require "./db/migrations/create_items_table"
require "./db/migrations/create_lists_table"
