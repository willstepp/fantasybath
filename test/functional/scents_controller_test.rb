require 'test_helper'

class ScentsControllerTest < ActionController::TestCase
  setup do
    @scent = scents(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:scents)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create scent" do
    assert_difference('Scent.count') do
      post :create, scent: {  }
    end

    assert_redirected_to scent_path(assigns(:scent))
  end

  test "should show scent" do
    get :show, id: @scent
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @scent
    assert_response :success
  end

  test "should update scent" do
    put :update, id: @scent, scent: {  }
    assert_redirected_to scent_path(assigns(:scent))
  end

  test "should destroy scent" do
    assert_difference('Scent.count', -1) do
      delete :destroy, id: @scent
    end

    assert_redirected_to scents_path
  end
end
