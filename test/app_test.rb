require "minitest/autorun"
require "minitest/pride"
require "rack/test"
require "./app.rb"

class AppTest < Minitest::Test
  include Rack::Test::Methods
  def app
    Sinatra::Application
  end

  def test_get_a_page_to_ask_for_a_zip
    get "/"
    assert last_response.ok?
    assert_match(/Enter the name of your first list!/, last_response.body)
  end
end
