require 'test_helper'

class LuzContractsControllerTest < ActionController::TestCase
  setup do
    @luz_contract = luz_contracts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:luz_contracts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create luz_contract" do
    assert_difference('LuzContract.count') do
      post :create, luz_contract: { contract_id: @luz_contract.contract_id, former_luz_owner_firstname: @luz_contract.former_luz_owner_firstname, former_luz_owner_lastname: @luz_contract.former_luz_owner_lastname }
    end

    assert_redirected_to luz_contract_path(assigns(:luz_contract))
  end

  test "should show luz_contract" do
    get :show, id: @luz_contract
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @luz_contract
    assert_response :success
  end

  test "should update luz_contract" do
    patch :update, id: @luz_contract, luz_contract: { contract_id: @luz_contract.contract_id, former_luz_owner_firstname: @luz_contract.former_luz_owner_firstname, former_luz_owner_lastname: @luz_contract.former_luz_owner_lastname }
    assert_redirected_to luz_contract_path(assigns(:luz_contract))
  end

  test "should destroy luz_contract" do
    assert_difference('LuzContract.count', -1) do
      delete :destroy, id: @luz_contract
    end

    assert_redirected_to luz_contracts_path
  end
end
