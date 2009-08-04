class UsersController < ApplicationController

  skip_before_filter :login_required
  before_filter :login_required, :except=>[:new, :create, :activate]

  # render new.rhtml
  def new
    @user = User.new
  end

  def update
    @user = User.find(params[:id])
    if @user != current_user
      return render(:json=>'[["base", "Can only change own details"]]', :status=>:unprocessable_entity)
    end
    if @user.update_attributes(params[:user])
      respond_to do |f|
        f.json {render :json=>@user}
      end
    else
      render :json => @user.errors, :status => :unprocessable_entity
    end
  end

  def show
    return show_current if 'current' == params[:id]
    render :status=>404, :text=>'Not supported'
  end

  def show_current
    render :json => current_user.to_json(:include => {:wallet => {:methods => :balance, :include => :wallet_transactions}})
  end

  def create
    logout_keeping_session!

    @user = User.new(params[:user])
    success = @user && @user.save
    status = success && @user.errors.empty?

    respond_to do |format|
      format.html {
        if status
          redirect_back_or_default('/')
          flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
        else
          flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
          render :action => 'new'
        end
      }
      format.json {
        if status
          render :json => @user.to_json(:include => {:wallet => {:methods => :balance, :include => :wallet_transactions}})
        else
          render :json => @user.errors, :status => :unprocessable_entity
        end
      }
    end
  end

  def activate
    logout_keeping_session!
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && user && !user.active?
      user.activate!
      flash[:notice] = "Signup complete! Please sign in to continue."
      redirect_to '/login'
    when params[:activation_code].blank?
      flash[:error] = "The activation code was missing.  Please follow the URL from your email."
      redirect_back_or_default('/')
    else
      flash[:error]  = "We couldn't find a user with that activation code -- check your email? Or maybe you've already activated -- try signing in."
      redirect_back_or_default('/')
    end
  end

end
