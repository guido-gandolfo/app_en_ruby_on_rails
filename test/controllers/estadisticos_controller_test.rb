require "test_helper"

class EstadisticosControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get estadisticos_new_url
    assert_response :success
  end

  test "should get edit" do
    get estadisticos_edit_url
    assert_response :success
  end

  test "should get todos" do
    get estadisticos_todos_url
    assert_response :success
  end

  test "should get vacunas" do
    get estadisticos_vacunas_url
    assert_response :success
  end
end
