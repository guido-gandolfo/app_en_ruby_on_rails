require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get editar_perfil" do
    get users_editar_perfil_url
    assert_response :success
  end

  test "should get infovacunas" do
    get users_infovacunas_url
    assert_response :success
  end

  test "should get perfil" do
    get users_perfil_url
    assert_response :success
  end

  test "should get turnos" do
    get users_turnos_url
    assert_response :success
  end
end
