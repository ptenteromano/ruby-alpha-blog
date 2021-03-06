require 'test_helper'
# feature testing!

class CreateCategoriesTest < ActionDispatch::IntegrationTest

  def setup
    @admin = User.create(username: "john", email: "john@example.com", password: "password", admin: true)
  end

  # goes to new page
  # Creates a new category 'Sports'
  # redirects to index page after posting create
  # asserts index has "Sports" in its body
  test "get new category form and create category" do
    sign_in_as(@admin, "password")
    get new_category_path
    assert_template 'categories/new'
    assert_difference 'Category.count', 1 do
      post categories_path, params: { category: { name: "Sports" } }
      follow_redirect!
    end
    assert_template 'categories/index'
    assert_match "Sports", response.body
  end

  test "invalid category submission results in failure" do
    sign_in_as(@admin, "password")
    get new_category_path
    assert_template 'categories/new'
    assert_no_difference 'Category.count' do
      post categories_path, params: { category: { name: " " } }
    end
    assert_template 'categories/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end

end