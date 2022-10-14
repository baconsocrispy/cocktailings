require "application_system_test_case"

class CabinetsTest < ApplicationSystemTestCase
  setup do
    @cabinet = cabinets(:one)
  end

  test "visiting the index" do
    visit cabinets_url
    assert_selector "h1", text: "Cabinets"
  end

  test "should create cabinet" do
    visit cabinets_url
    click_on "New cabinet"

    click_on "Create Cabinet"

    assert_text "Cabinet was successfully created"
    click_on "Back"
  end

  test "should update Cabinet" do
    visit cabinet_url(@cabinet)
    click_on "Edit this cabinet", match: :first

    click_on "Update Cabinet"

    assert_text "Cabinet was successfully updated"
    click_on "Back"
  end

  test "should destroy Cabinet" do
    visit cabinet_url(@cabinet)
    click_on "Destroy this cabinet", match: :first

    assert_text "Cabinet was successfully destroyed"
  end
end
