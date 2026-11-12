require "test_helper"

class TodosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(name: "Test User", email: "test@example.com", password: "password123")
    post login_path, params: { email: @user.email, password: "password123" }
    follow_redirect!
  end

  test "new todo form does not expose a user id field" do
    get new_todo_path

    assert_response :success
    assert_no_match /name="todo\[user_id\]"/, @response.body
  end
end
