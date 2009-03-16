require File.dirname(__FILE__) + '/../test_helper'
require 'users_controller'

# Re-raise errors caught by the controller.
class UsersController; def rescue_action(e) raise e end; end

class UsersControllerTest < ActionController::TestCase

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
  
  context "successfully updating user through json" do
    QUENTIN_ID = Fixtures::identify(:quentin)

    setup do
      put :update, :id=>QUENTIN_ID, 
        :user=>{:income=>'123456', :birthdate=>'21 May 2002', :gender=>'M'},:format=>'json'
      @user = users(:quentin)
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
  
 
  context "showing logged in user, using json" do
    setup do
      login_as :quentin
      get :show_current, :format=>:json
    end
    
    should_respond_with :success
    should_respond_with_content_type :json

    should "return current user in json form" do
      assert_equal users(:quentin).to_json, @response.body
    end

    
    should_route :get, '/users/current', :action=>:show_current, :controller=>:users
  end
  
  context "failing to update user through json" do
    setup do
      put :update, :id=>QUENTIN_ID, :user=>{:email=>''}, :format=>'json'
    end
    should_respond_with :unprocessable_entity
    should_respond_with_content_type :json
    
    should "contain the errors" do
      assert_match /can\'t be blank/, @response.body
    end
 
  end
  

  protected
    def create_user(options = {})
      post :create, :user => { :login => 'quire', :email => 'quire@example.com',
        :password => 'quire69', :password_confirmation => 'quire69' }.merge(options)
    end
end
