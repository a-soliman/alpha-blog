require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest
  def setup
    @admin_user = User.create(username: "johnAdmin", email: "john@mail.com", password: "password", admin: true)
    @regular_user = User.create(username: "jane", email: "jane@mail.com", password: "password")
  end

  test "Get new category form and create category" do
    sign_in_as(@admin_user)

    get new_category_url
    assert_response :success

    assert_difference('Category.count') do
      post categories_url, params: { category: { name: 'Sports'} }
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "Sports", response.body
  end

  test "Get new category form and reject invalid category submission" do
    sign_in_as(@admin_user)
    
    get new_category_url
    assert_response :success

    assert_no_difference('Category.count') do
      post categories_url, params: { category: { name: ''} }
    end
    assert_response :bad_request
    assert_match "Name can&#39;t be blank", response.body
    assert_select "div.alert"
  end
end
