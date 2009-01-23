require File.dirname(__FILE__) + '/../test_helper'

class SamTest < ActiveSupport::TestCase
  # Be sure to include AuthenticatedTestHelper in test/test_helper.rb instead.
  # Then, you can remove it from this and the functional test.
  include AuthenticatedTestHelper
  fixtures :sams

  def test_should_create_sam
    assert_difference 'Sam.count' do
      sam = create_sam
      assert !sam.new_record?, "#{sam.errors.full_messages.to_sentence}"
    end
  end

  def test_should_require_login
    assert_no_difference 'Sam.count' do
      u = create_sam(:login => nil)
      assert u.errors.on(:login)
    end
  end

  def test_should_require_password
    assert_no_difference 'Sam.count' do
      u = create_sam(:password => nil)
      assert u.errors.on(:password)
    end
  end

  def test_should_require_password_confirmation
    assert_no_difference 'Sam.count' do
      u = create_sam(:password_confirmation => nil)
      assert u.errors.on(:password_confirmation)
    end
  end

  def test_should_require_email
    assert_no_difference 'Sam.count' do
      u = create_sam(:email => nil)
      assert u.errors.on(:email)
    end
  end

  def test_should_reset_password
    sams(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal sams(:quentin), Sam.authenticate('quentin', 'new password')
  end

  def test_should_not_rehash_password
    sams(:quentin).update_attributes(:login => 'quentin2')
    assert_equal sams(:quentin), Sam.authenticate('quentin2', 'monkey')
  end

  def test_should_authenticate_sam
    assert_equal sams(:quentin), Sam.authenticate('quentin', 'monkey')
  end

  def test_should_set_remember_token
    sams(:quentin).remember_me
    assert_not_nil sams(:quentin).remember_token
    assert_not_nil sams(:quentin).remember_token_expires_at
  end

  def test_should_unset_remember_token
    sams(:quentin).remember_me
    assert_not_nil sams(:quentin).remember_token
    sams(:quentin).forget_me
    assert_nil sams(:quentin).remember_token
  end

  def test_should_remember_me_for_one_week
    before = 1.week.from_now.utc
    sams(:quentin).remember_me_for 1.week
    after = 1.week.from_now.utc
    assert_not_nil sams(:quentin).remember_token
    assert_not_nil sams(:quentin).remember_token_expires_at
    assert sams(:quentin).remember_token_expires_at.between?(before, after)
  end

  def test_should_remember_me_until_one_week
    time = 1.week.from_now.utc
    sams(:quentin).remember_me_until time
    assert_not_nil sams(:quentin).remember_token
    assert_not_nil sams(:quentin).remember_token_expires_at
    assert_equal sams(:quentin).remember_token_expires_at, time
  end

  def test_should_remember_me_default_two_weeks
    before = 2.weeks.from_now.utc
    sams(:quentin).remember_me
    after = 2.weeks.from_now.utc
    assert_not_nil sams(:quentin).remember_token
    assert_not_nil sams(:quentin).remember_token_expires_at
    assert sams(:quentin).remember_token_expires_at.between?(before, after)
  end

protected
  def create_sam(options = {})
    record = Sam.new({ :login => 'quire', :email => 'quire@example.com', :password => 'quire69', :password_confirmation => 'quire69' }.merge(options))
    record.save
    record
  end
end
