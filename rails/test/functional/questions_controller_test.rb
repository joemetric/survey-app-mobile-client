require File.join(File.dirname(__FILE__), '..', 'test_helper')

class QuestionsControllerTest < ActionController::TestCase
  def setup
    login_as :quentin
  end
  
  def test_should_get_index
    get :index, :survey_id => surveys(:one).id
    assert_response :success
    assert_not_nil assigns(:questions)
  end

  def test_should_get_new
    get :new, :survey_id => surveys(:one).id
    assert_response :success
  end

  def test_should_create_question
    assert_difference('Question.count') do
      post :create, :question => { :text => "Question text" }, :survey_id => surveys(:one).id
    end

    assert_redirected_to survey_question_path(surveys(:one), assigns(:question))
  end

  def test_should_show_question
    get :show, :id => questions(:one).id, :survey_id => surveys(:one)
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => questions(:one).id, :survey_id => surveys(:one)
    assert_response :success
  end

  def test_should_update_question
    put :update, :id => questions(:one).id, :question => { }, :survey_id => surveys(:one)
    assert_redirected_to survey_question_path(surveys(:one), assigns(:question))
  end

  def test_should_destroy_question
    assert_difference('Question.count', -1) do
      delete :destroy, :id => questions(:one).id, :survey_id => surveys(:one)
    end

    assert_redirected_to survey_questions_path(surveys(:one))
  end
end
