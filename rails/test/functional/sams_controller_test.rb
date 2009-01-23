require File.dirname(__FILE__) + '/../test_helper'
require 'sams_controller'

# Re-raise errors caught by the controller.
class SamsController; def rescue_action(e) raise e end; end

class SamsControllerTest < ActionController::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead
  # Then, you can remove it from this and the units test.
  include AuthenticatedTestHelper

  fixtures :sams

  def test_should_allow_signup
    assert_difference 'Sam.count' do
      create_sam
      assert_response :redirect
    end
  end

  def test_should_require_login_on_signup
    assert_no_difference 'Sam.count' do
      create_sam(:login => nil)
      assert assigns(:sam).errors.on(:login)
      assert_response :success
    end
  end

  def test_should_require_password_on_signup
    assert_no_difference 'Sam.count' do
      create_sam(:password => nil)
      assert assigns(:sam).errors.on(:password)
      assert_response :success
    end
  end

  def test_should_require_password_confirmation_on_signup
    assert_no_difference 'Sam.count' do
      create_sam(:password_confirmation => nil)
      assert assigns(:sam).errors.on(:password_confirmation)
      assert_response :success
    end
  end

  def test_should_require_email_on_signup
    assert_no_difference 'Sam.count' do
      create_sam(:email => nil)
      assert assigns(:sam).errors.on(:email)
      assert_response :success
    end
  end
  

  

  protected
    def create_sam(options = {})
      post :create, :sam => { :login => 'quire', :email => 'quire@example.com',
        :password => 'quire69', :password_confirmation => 'quire69' }.merge(options)
    end
end
