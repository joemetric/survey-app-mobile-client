require File.dirname(__FILE__) + '/../test_helper'
require 'users_controller'

# Re-raise errors caught by the controller.
class UsersController
  def rescue_action(e)
    raise e
  end
end

class UsersControllerTest < ActionController::TestCase
  QUENTIN_ID = Fixtures::identify(:quentin)

  fixtures :users

  def test_should_allow_signup
    assert_difference 'User.count' do
      create_user
      assert_response :redirect
    end
  end

  def test_should_require_login_on_signup
    assert_no_difference 'User.count' do
      create_user(:login => nil)
      assert assigns(:user).errors.on(:login)
      assert_response :success
    end
  end

  def test_should_require_password_on_signup
    assert_no_difference 'User.count' do
      create_user(:password => nil)
      assert assigns(:user).errors.on(:password)
      assert_response :success
    end
  end

  def test_should_require_password_confirmation_on_signup
    assert_no_difference 'User.count' do
      create_user(:password_confirmation => nil)
      assert assigns(:user).errors.on(:password_confirmation)
      assert_response :success
    end
  end

  def test_should_require_email_on_signup
    assert_no_difference 'User.count' do
      create_user(:email => nil)
      assert assigns(:user).errors.on(:email)
      assert_response :success
    end
  end

  def test_should_sign_up_user_with_activation_code
    create_user
    assigns(:user).reload
    assert_not_nil assigns(:user).activation_code
  end

  def test_should_activate_user
    assert_nil User.authenticate('aaron', 'test')
    get :activate, :activation_code => users(:aaron).activation_code
    assert_redirected_to '/sessions/new'
    assert_not_nil flash[:notice]
    assert_equal users(:aaron), User.authenticate('aaron', 'monkey')
  end

  def test_should_not_activate_user_without_key
    get :activate
    assert_nil flash[:notice]
  rescue ActionController::RoutingError
    # in the event your routes deny this, we'll just bow out gracefully.
  end

  def test_should_not_activate_user_with_blank_key
    get :activate, :activation_code => ''
    assert_nil flash[:notice]
  rescue ActionController::RoutingError
    # well played, sir
  end

  context "successfully updating user through json" do

    setup do
      login_as :quentin
      put :update, :id=>QUENTIN_ID,
        :user=>{:income=>'123456', :birthdate=>'21 May 2002', :gender=>'M'},:format=>'json'
      @user = users(:quentin).reload
    end

    should "cause fields to be updated" do
      assert_equal '123456', @user.income
      assert_equal Date::civil(2002, 5, 21), @user.birthdate
      assert_equal 'M', @user.gender

    end

    should_route :put, "/users/#{QUENTIN_ID}", :controller=>:users, :action=>:update, :id=>QUENTIN_ID

    should_respond_with :success
    should_respond_with_content_type :json

    should "return user in json form" do
      assert_equal @user.to_json, @response.body
    end

  end

  context "attempting to update a user other than the logged-in user" do
    setup do
      login_as :aaron
      put :update, :id=>QUENTIN_ID, :user=>{},:format=>'json'
    end

    should_respond_with :unprocessable_entity
  end

  context "failing to update user through json" do
    setup do
      login_as :quentin
      put :update, :id=>QUENTIN_ID, :user=>{:email=>''}, :format=>'json'
    end
    should_respond_with :unprocessable_entity
    should_respond_with_content_type :json

    should "contain the errors" do
      assert_match /can\'t be blank/, @response.body
    end

  end


  context "showing logged in user, using json" do
    setup do
      login_as :quentin
      get :show, :id=>'current', :format=>:json
    end

    should_respond_with :success
    should_respond_with_content_type :json

    should "return current user in json form" do
      assert_equal users(:quentin).to_json(:include => {:wallet => {:methods => :balance, :include => :wallet_transactions}}), @response.body
    end
  end

  context "show user without id current 404s" do
    setup do
      login_as :quentin
      get :show, :id=>QUENTIN_ID, :format=>:json
    end

    should_respond_with 404
  end


  context "unauthenticated user" do
    should "be able to create user" do
      post :create
      assert_response :success
    end

    should "be able to display new" do
      get :new
      assert_response :success
    end

    should "be denied update" do
      put :update, :id=>QUENTIN_ID, :user=>{},:format=>'json'
      assert_response 401
    end

    should "be denied show_current" do
      get :show, :id=>'current', :user=>{},:format=>'json'
      assert_response 401
    end


  end


  protected
    def create_user(options = {})
      post :create, :user => { :login => 'quire', :email => 'quire@example.com',
        :password => 'quire69', :password_confirmation => 'quire69' }.merge(options)
    end
end
