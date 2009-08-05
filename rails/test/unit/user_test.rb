require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users

  def test_should_create_user
    assert_difference 'User.count' do
      user = create_user
      assert !user.new_record?, "#{user.errors.full_messages.to_sentence}"
    end
  end

  def test_should_require_login
    assert_no_difference 'User.count' do
      u = create_user(:login => nil)
      assert u.errors.on(:login)
    end
  end

  def test_should_require_password
    assert_no_difference 'User.count' do
      u = create_user(:password => nil)
      assert u.errors.on(:password)
    end
  end

  def test_should_require_password_confirmation
    assert_no_difference 'User.count' do
      u = create_user(:password_confirmation => nil)
      assert u.errors.on(:password_confirmation)
    end
  end

  def test_should_require_email
    assert_no_difference 'User.count' do
      u = create_user(:email => nil)
      assert u.errors.on(:email)
    end
  end

  def test_should_reset_password
    users(:quentin).update_attributes(:password => 'new password', :password_confirmation => 'new password')
    assert_equal users(:quentin), User.authenticate('quentin', 'new password')
  end

  def test_should_not_rehash_password
    users(:quentin).update_attributes(:login => 'quentin2')
    assert_equal users(:quentin), User.authenticate('quentin2', 'monkey')
  end

  def test_should_authenticate_user
    assert_equal users(:quentin), User.authenticate('quentin', 'monkey')
  end

  def test_should_set_remember_token
    users(:quentin).remember_me
    assert_not_nil users(:quentin).remember_token
    assert_not_nil users(:quentin).remember_token_expires_at
  end

  def test_should_unset_remember_token
    users(:quentin).remember_me
    assert_not_nil users(:quentin).remember_token
    users(:quentin).forget_me
    assert_nil users(:quentin).remember_token
  end

  def test_should_remember_me_for_one_week
    before = 1.week.from_now.utc
    users(:quentin).remember_me_for 1.week
    after = 1.week.from_now.utc
    assert_not_nil users(:quentin).remember_token
    assert_not_nil users(:quentin).remember_token_expires_at
    assert users(:quentin).remember_token_expires_at.between?(before, after)
  end

  def test_should_remember_me_until_one_week
    time = 1.week.from_now.utc
    users(:quentin).remember_me_until time
    assert_not_nil users(:quentin).remember_token
    assert_not_nil users(:quentin).remember_token_expires_at
    assert_equal users(:quentin).remember_token_expires_at, time
  end

  def test_should_remember_me_default_two_weeks
    before = 2.weeks.from_now.utc
    users(:quentin).remember_me
    after = 2.weeks.from_now.utc
    assert_not_nil users(:quentin).remember_token
    assert_not_nil users(:quentin).remember_token_expires_at
    assert users(:quentin).remember_token_expires_at.between?(before, after)
  end

  def test_should_initialize_activation_code_upon_creation
    user = create_user
    user.reload
    assert_not_nil user.activation_code
  end

  context "Completing a survey" do
    setup do
      @user = users(:aaron)
      @survey = surveys(:one)
    end
    should "update the wallet" do
      assert_equal 0, @user.wallet.balance
      @user.complete_survey(@survey)
      assert_equal @survey.amount, @user.wallet.balance
    end
  end

  context "Demographic data" do

    setup do
      @user = User.new
    end

    context "when accessing the age" do

      should "cache the age object" do
        assert_same @user.age, @user.age
      end

      context "when checking whether this age is within another" do

        setup do
          @user.birthdate = 10.years.ago.to_date
        end

        should "be true when the age is the minimum" do
          assert @user.age.within?(10, 15)
        end

        should "be true when the birthdate falls within the range of ages" do
          assert @user.age.within?(5, 15)
        end

        should "be true when the age is the maximum" do
          assert @user.age.within?(5, 10)
        end

        should "be false when the birthdate when it is less than the minimum age" do
          assert !@user.age.within?(15, 20)
        end

        should "be false when the birthdate when it is greater than the maximum age" do
          assert !@user.age.within?(5, 9)
        end

      end

    end

    context "when accessing the income" do

      should "cache the age object" do
        assert_same @user.income, @user.income
      end

      context "when checking whether this income is within another" do

        setup do
          @user.income = 10
        end

        should "be true when the income is the minimum" do
          assert @user.income.within?(10, 15)
        end

        should "be true when the income falls within the range of incomes" do
          assert @user.income.within?(5, 15)
        end

        should "be true when the income is the maximum" do
          assert @user.income.within?(5, 10)
        end

        should "be false when the income when it is less than the minimum income" do
          assert !@user.income.within?(15, 20)
        end

        should "be false when the income when it is greater than the maximum income" do
          assert !@user.income.within?(5, 9)
        end

      end

    end

  end

protected
  def create_user(options = {})
    record = User.new({ :login => 'quire', :email => 'quire@example.com', :password => 'quire69', :password_confirmation => 'quire69' }.merge(options))
    record.save
    record
  end
end
