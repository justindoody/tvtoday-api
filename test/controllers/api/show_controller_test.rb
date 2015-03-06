require 'test_helper'

class Api::ShowsControllerTest < ActionController::TestCase
  test 'should get api index' do
    get :index
    assert_response :success
  end

  test 'should get index as all shows json' do
    get :index, format: :json
    assert_response :success
  end

  test 'add new show without authentication' do
    get :new
    assert_equal 302, response.status
  end

  test 'create new show without authentication' do
    post :create
    assert_equal 302, response.status
  end

  test 'manually trigger update without authentication' do
    get :update_all
    assert_equal 302, response.status
  end

  test 'show json data' do
    get :tvdbid, { format: :json, 'id' => '111_111' }
    assert_response :success
  end

end
