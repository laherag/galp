require 'test_helper'

class GazContractsControllerTest < ActionController::TestCase
  setup do
    @gaz_contract = gaz_contracts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gaz_contracts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gaz_contract" do
    assert_difference('GazContract.count') do
      post :create, gaz_contract: { former_gaz_owner_firstname: @gaz_contract.former_gaz_owner_firstname, former_gaz_owner_lastname: @gaz_contract.former_gaz_owner_lastname }
    end

    assert_redirected_to gaz_contract_path(assigns(:gaz_contract))
  end

  test "should show gaz_contract" do
    get :show, id: @gaz_contract
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gaz_contract
    assert_response :success
  end

  test "should update gaz_contract" do
    patch :update, id: @gaz_contract, gaz_contract: { former_gaz_owner_firstname: @gaz_contract.former_gaz_owner_firstname, former_gaz_owner_lastname: @gaz_contract.former_gaz_owner_lastname }
    assert_redirected_to gaz_contract_path(assigns(:gaz_contract))
  end

  test "should destroy gaz_contract" do
    assert_difference('GazContract.count', -1) do
      delete :destroy, id: @gaz_contract
    end

    assert_redirected_to gaz_contracts_path
  end
end
