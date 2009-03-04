class UsersController < ApplicationController

  skip_before_filter :login_required

  # render new.rhtml
  def new
    @user = User.new
  end
 
  def create
    logout_keeping_session!

    @user = User.new(params[:user])
    success = @user && @user.save
    status = success && @user.errors.empty?

    respond_to do |format|
      format.html {
        if status
          self.current_user = @user
          redirect_back_or_default('/')
          flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
        else
          flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
          render :action => 'new'
        end
      }
      format.json { render :json => status ? @user : '' }
    end
  end
end
