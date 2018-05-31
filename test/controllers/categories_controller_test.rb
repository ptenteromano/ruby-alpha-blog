require 'test_helper'
# Lecture 131

                        # new to rails 5: Controller is an Integration Test
class CategoriesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @category = Category.create(name: "Sports")
    @admin = User.create(username: "john", email: "john@example.com", password: "password", admin: true)
  end

  test "should get categories index" do
    # rails documentation says categories_url, both work
    get categories_path  # replaced :index
    assert_response :success
  end

  test "should get new" do
    sign_in_as(@admin, "password")
    get new_category_path # rails 5 specific, replaced :new
    assert_response :success
  end

  test "should get show" do
    get category_path(@category)   # rails 5 specific, replaced :show
    assert_response :success
  end

  test "should redirect create when admin not logged in" do
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: { name: "Sports" } }
    end
    assert_redirected_to categories_path
  end

end