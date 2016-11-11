require "minitest/autorun"
require "minitest/pride"
require "rack/test"
require "./test/test_helper"

class AppTest < Minitest::Test
  include Rack::Test::Methods
  def app
    Sinatra::Application
  end

  def setup
    List.delete_all
    Item.delete_all
    @groceries = List.create!(name: "groceries")
    @bananas = @groceries.items.create!(name: "bananas")
  end

  def test_get_home_page_to_load_which_links_to_lists_index
    get "/"
    assert_match(/all of the things/, last_response.body)
  end

  def test_can_access_lists_index_page
    get "/lists"
    assert_match(/Add a new list!/, last_response.body)
  end

  def test_can_create_a_new_list
    post "/lists", list: { name: "shopping" }
    assert_equal "shopping", List.last.name
  end

  def test_can_delete_list
    delete "/lists/#{@groceries.id}"
    assert_raises do
      List.find(name: "groceries")
    end
  end

  def test_can_edit_list_name
    patch "/lists/#{@groceries.id}/edit", list: { name: "shopping" }
    assert_equal "shopping", List.last.name
  end

  def test_can_access_list_name_edit_page
    get "/lists/#{@groceries.id}/edit"
    assert_match(/Update your list's name/, last_response.body)
  end

  def test_can_access_view_to_create_list
    get "/lists/new"
    assert_match(/Give your new list a name!/, last_response.body)
  end

  def test_can_access_items_of_a_specific_list
    get "/lists/#{@groceries.id}"
    assert_match(/bananas/, last_response.body)
  end

  def test_can_access_new_item_view
    get "/lists/#{@groceries.id}/items/new"
    assert_match(/Give your new item a name and due date/, last_response.body)
  end
end
