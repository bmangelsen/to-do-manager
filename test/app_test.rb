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
    assert_match(/Add a new list/, last_response.body)
  end

  def test_can_access_view_to_create_list
    get "/lists/new"
    assert_match(/Give your new list a name!/, last_response.body)
  end

  def test_can_create_a_new_list
    post "/lists", list: { name: "shopping" }
    assert_equal "shopping", List.last.name
  end

  def test_can_access_view_to_edit_list_name
    get "/lists/#{@groceries.id}/edit"
    assert_match(/Update your list's name/, last_response.body)
  end

  def test_can_edit_list_name
    patch "/lists/#{@groceries.id}/edit", list: { name: "shopping" }
    assert_equal "shopping", List.last.name
  end

  def test_can_delete_list
    delete "/lists/#{@groceries.id}"
    assert_raises do
      List.find(name: "groceries")
    end
    assert List.all.empty?
  end

  def test_deleting_list_deletes_items_within
    delete "/lists/#{@groceries.id}"
    assert_raises do
      Item.find(name: "bananas")
    end
    assert Item.all.empty?
  end

  def test_can_access_view_of_items_for_specific_list
    get "/lists/#{@groceries.id}"
    assert_match(/bananas/, last_response.body)
  end

  def test_can_access_view_to_add_item
    get "/lists/#{@groceries.id}/items/new"
    assert_match(/Give your new item a name!/, last_response.body)
  end

  def test_can_add_item_to_list
    post "/items", item: { name: "apples", list_id: @groceries.id }
    assert_equal "apples", @groceries.items.last.name
  end

  def can_delete_item
    delete "/items/#{@bananas.id}"
    assert_raises do
      Item.find(name: "bananas")
    end
    assert @groceries.items.emtpy?
  end

  def test_can_access_view_to_edit_item
    get "/items/#{@bananas.id}/edit"
    assert_match(/Update your item's name, due date, or comments/, last_response.body)
  end

  def test_can_edit_item_name
    patch "/items/#{@bananas.id}/edit", item: { name: "apples" }
    assert_equal "apples", Item.last.name
  end

  def test_can_access_view_for_specific_item
    get "/items/#{@bananas.id}"
    assert_match(/Here are some details about your item/, last_response.body)
  end

  def test_picking_random_from_all_items_redirects_to_view_for_specific_item
    get "/next"
    assert_match(/Here are some details about your item/, last_response.body)
  end

  def test_picking_random_from_list_items_redirects_to_view_for_specific_item
    get "/next/#{@bananas.id}"
    assert_match(/Here are some details about your item/, last_response.body)
  end

  def test_can_search_for_items
    get "/search", item: { name: "ban" }
    assert_match(/bananas/, last_response.body)
    assert_match(/Here's the list of items matching your search:/, last_response.body)
  end
end
