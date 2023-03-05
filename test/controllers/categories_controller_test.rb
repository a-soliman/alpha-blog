require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @admin_user = User.create(username: "johnAdmin", email: "john@mail.com", password: "password", admin: true)
    @regular_user = User.create(username: "jane", email: "jane@mail.com", password: "password")
  end
  
  test "Should get index" do
    get categories_url
    assert_response :success
  end

  test "Should get new" do
    sign_in_as(@admin_user)
    get new_category_url
    assert_response :success
  end

  test "Should create category if name was valid" do
    sign_in_as(@admin_user)
    assert_difference('Category.count') do
      post categories_url, params: { category: { name: 'test' }}
    end

    assert_redirected_to category_url(Category.last)
  end

  test "Should not create category if current user is not admin" do
    sign_in_as(@regular_user)
    assert_no_difference('Category.count') do
      post categories_url, params: { category: { name: 'test' }}
    end

    assert_response :forbidden
  end

  test "Should not create category if name was invalid" do
    sign_in_as(@admin_user)
    assert_no_difference('Category.count') do
      post categories_url, params: { category: { name: '' }}
    end

    assert_response :bad_request
  end

  test "Should show category" do
    @category = Category.create(name: 'test')

    get category_url(@category)
    assert_response :success
  end
end