require "test_helper"

class WeeklySessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get weekly_sessions_index_url
    assert_response :success
  end
end
