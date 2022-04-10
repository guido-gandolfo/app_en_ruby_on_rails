require "test_helper"

class VaccinatorsControllerTest < ActionDispatch::IntegrationTest
  test "should get listar" do
    get vaccinators_listar_url
    assert_response :success
  end

  test "should get asignar" do
    get vaccinators_asignar_url
    assert_response :success
  end
end
