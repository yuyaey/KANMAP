require 'test_helper'

class KanzumesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get kanzumes_index_url
    assert_response :success
  end

  test "should get show" do
    get kanzumes_show_url
    assert_response :success
  end

  test "should get new" do
    get kanzumes_new_url
    assert_response :success
  end

  test "should get edit" do
    get kanzumes_edit_url
    assert_response :success
  end

end
