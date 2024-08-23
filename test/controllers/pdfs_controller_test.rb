require "test_helper"

class PdfsControllerTest < ActionDispatch::IntegrationTest
  test "should get upload" do
    get pdfs_upload_url
    assert_response :success
  end

  test "should get chat" do
    get pdfs_chat_url
    assert_response :success
  end
end
