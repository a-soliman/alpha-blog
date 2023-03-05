require "test_helper"

class ListCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @category1 = Category.create(name: "Sports")
    @category2 = Category.create(name: "Tech")
  end
  
  test "Should show categories listing" do
    get categories_url
    assert_response :success

    assert(Category.count == 2)

    assert_select "a[href=?]", category_path(@category1), text: @category1.name
    assert_select "a[href=?]", category_path(@category2), text: @category2.name
  end
end
