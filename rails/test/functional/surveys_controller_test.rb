require File.join(File.dirname(__FILE__), '..', 'test_helper')

class SurveysControllerTest < ActionController::TestCase
  fixtures :users, :surveys

  def setup
    login_as :quentin
  end

  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:surveys)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_survey
    assert_difference('Survey.count') do
      post :create, :survey => { :name => "new survey", :amount => 1.2 }
    end

    assert_redirected_to survey_path(assigns(:survey))
  end

  def test_should_show_survey
    get :show, :id => surveys(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => surveys(:one).id
    assert_response :success
  end

  def test_should_update_survey
    put :update, :id => surveys(:one).id, :survey => { }
    assert_redirected_to survey_path(assigns(:survey))
  end

  def test_should_destroy_survey
    assert_difference('Survey.count', -1) do
      delete :destroy, :id => surveys(:one).id
    end

    assert_redirected_to surveys_path
  end
end
