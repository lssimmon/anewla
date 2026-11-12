require "test_helper"

class WeightsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(name: "Test User", email: "test@example.com", password: "password123")
    post login_path, params: { email: @user.email, password: "password123" }
    follow_redirect!
  end

  test "health page shows track weight link" do
    get health_path

    assert_response :success
    assert_select "a", text: /Track Weight/i
  end

  test "creating a weight entry converts kilograms to pounds" do
    post weights_path, params: {
      weight_entry: {
        recorded_on: Date.current,
        weight: "100",
        unit: "kg"
      }
    }

    assert_response :redirect
    assert_equal 220.462, @user.weight_entries.first.weight
  end
end
