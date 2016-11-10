require "./test/test_helper"

class ItemTest < Minitest::Test
  def setup
    Item.delete_all
  end

  def test_class_exists
    Item
  end

  def test_list_can_be_saved_to_db
    assert Item.create!(name: "bananas")
  end

  def test_list_needs_a_name
    assert_raises do
      Item.create!
    end
  end
end
