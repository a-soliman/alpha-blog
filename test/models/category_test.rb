require 'test_helper'

class CategoryTest < ActiveSupport::TestCase

  def setup
    @category = Category.new
  end

  test "Category should be invlaid if name was not provided" do
    assert_not @category.valid?
  end

  test "Category should be invalid if name length is less than 3" do
    @category.name = "ab"
    assert_not @category.valid?
  end

  test "Category should be invalid if name length is greater than 20" do
    @category.name = "abcdefghijklmnopqrstu"
    assert_not @category.valid?
  end

  test "Category should be invalid if name is empty" do
    @category.name = " "
    assert_not @category.valid?
  end

  test "Category should be valid if name was provided" do
    @category.name = "Sports"
    assert @category.valid?
  end

  test "Category name should be unique" do
    another_category = Category.new(name: "abc").save
    @category.name = "abc"
    assert_not @category.valid?
  end

end