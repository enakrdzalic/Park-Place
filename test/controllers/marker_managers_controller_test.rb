require 'test_helper'

class MarkerManagersControllerTest < ActionController::TestCase
  setup do
    @marker_manager = marker_managers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:marker_managers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create marker_manager" do
    assert_difference('MarkerManager.count') do
      post :create, marker_manager: {  }
    end

    assert_redirected_to marker_manager_path(assigns(:marker_manager))
  end

  test "should show marker_manager" do
    get :show, id: @marker_manager
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @marker_manager
    assert_response :success
  end

  test "should update marker_manager" do
    patch :update, id: @marker_manager, marker_manager: {  }
    assert_redirected_to marker_manager_path(assigns(:marker_manager))
  end

  test "should destroy marker_manager" do
    assert_difference('MarkerManager.count', -1) do
      delete :destroy, id: @marker_manager
    end

    assert_redirected_to marker_managers_path
  end
end
