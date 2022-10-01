require "test_helper"

class PortionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @portion = portions(:one)
  end

  test "should get index" do
    get portions_url
    assert_response :success
  end

  test "should get new" do
    get new_portion_url
    assert_response :success
  end

  test "should create portion" do
    assert_difference("Portion.count") do
      post portions_url, params: { portion: { amount: @portion.amount, unit: @portion.unit } }
    end

    assert_redirected_to portion_url(Portion.last)
  end

  test "should show portion" do
    get portion_url(@portion)
    assert_response :success
  end

  test "should get edit" do
    get edit_portion_url(@portion)
    assert_response :success
  end

  test "should update portion" do
    patch portion_url(@portion), params: { portion: { amount: @portion.amount, unit: @portion.unit } }
    assert_redirected_to portion_url(@portion)
  end

  test "should destroy portion" do
    assert_difference("Portion.count", -1) do
      delete portion_url(@portion)
    end

    assert_redirected_to portions_url
  end
end
