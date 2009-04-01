class UsersController < ApplicationController

  skip_before_filter :login_required
  before_filter :login_required, :except=>[:new, :create]

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
    render :json => current_user.to_json(:include => :wallet)
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
      format.json {
        if status
          render :json => @user.to_json(:include => :wallet)
        else
          render :json => @user.errors, :status => :unprocessable_entity
        end
      }
    end
  end
end
