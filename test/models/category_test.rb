require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @category = @user.categories.build(name: "Work")
  end

  test "name should be present" do
    @category.name = ""
    assert_not @category.valid?
  end

  test "name should be unique per user" do
    duplicate_category = @user.categories.build(name: categories(:one).name)
    assert_not duplicate_category.valid?
  end

  test "name should have a length between 2 and 30 characters" do
    @category.name = "A"
    assert_not @category.valid?

    @category.name = "Work"
    assert @category.valid?
  end

  test "should belong to a user" do
    assert_equal @user, @category.user
  end
end
