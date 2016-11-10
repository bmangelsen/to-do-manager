require "./test/test_helper"

class ListTest < Minitest::Test
  def setup
    List.delete_all
  end

  def test_class_exists
    List
  end

  def test_list_can_be_saved_to_db
    assert List.create!(name: "groceries")
  end

  def test_list_needs_a_name
    assert_raises do
      List.create!
    end
  end
end
