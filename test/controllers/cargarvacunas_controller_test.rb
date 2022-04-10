require "test_helper"

class CargarvacunasControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get cargarvacunas_new_url
    assert_response :success
  end
end
