require "minitest/autorun"
require "minitest/pride"
require "rack/test"
require "./app.rb"

class AppTest < Minitest::Test
  include Rack::Test::Methods
  def app
    Sinatra::Application
  end

  def test_get_home_page_to_load_which_links_to_lists_index
    get "/"
    assert last_response.ok?
    assert_match(/all of the things/, last_response.body)
  end

  def test_can_access_lists_index
    get "/lists"
    assert_match(/Add a new list!/, last_response.body)
  end

  def test_can_access_new_list_page
    get "/lists/new"
    assert_match(/Give your new list a name!/, last_response.body)
  end

  def test_can_access_items_of_a_specific_list
    get "/lists/1"
    assert_match(/Add a new item to/, last_response.body)
  end
end
