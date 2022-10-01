require "application_system_test_case"

class PortionsTest < ApplicationSystemTestCase
  setup do
    @portion = portions(:one)
  end

  test "visiting the index" do
    visit portions_url
    assert_selector "h1", text: "Portions"
  end

  test "should create portion" do
    visit portions_url
    click_on "New portion"

    fill_in "Amount", with: @portion.amount
    fill_in "Unit", with: @portion.unit
    click_on "Create Portion"

    assert_text "Portion was successfully created"
    click_on "Back"
  end

  test "should update Portion" do
    visit portion_url(@portion)
    click_on "Edit this portion", match: :first

    fill_in "Amount", with: @portion.amount
    fill_in "Unit", with: @portion.unit
    click_on "Update Portion"

    assert_text "Portion was successfully updated"
    click_on "Back"
  end

  test "should destroy Portion" do
    visit portion_url(@portion)
    click_on "Destroy this portion", match: :first

    assert_text "Portion was successfully destroyed"
  end
end
