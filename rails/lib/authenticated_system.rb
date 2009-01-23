module AuthenticatedSystem
  protected
    # Returns true or false if the sam is logged in.
    # Preloads @current_sam with the sam model if they're logged in.
    def logged_in?
      !!current_sam
    end

    # Accesses the current sam from the session.
    # Future calls avoid the database because nil is not equal to false.
    def current_sam
      @current_sam ||= (login_from_session || login_from_basic_auth || login_from_cookie) unless @current_sam == false
    end

    # Store the given sam id in the session.
    def current_sam=(new_sam)
      session[:sam_id] = new_sam ? new_sam.id : nil
      @current_sam = new_sam || false
    end

    # Check if the sam is authorized
    #
    # Override this method in your controllers if you want to restrict access
    # to only a few actions or if you want to check if the sam
    # has the correct rights.
    #
    # Example:
    #
    #  # only allow nonbobs
    #  def authorized?
    #    current_sam.login != "bob"
    #  end
    #
    def authorized?(action = action_name, resource = nil)
      logged_in?
    end

    # Filter method to enforce a login requirement.
    #
    # To require logins for all actions, use this in your controllers:
    #
    #   before_filter :login_required
    #
    # To require logins for specific actions, use this in your controllers:
    #
    #   before_filter :login_required, :only => [ :edit, :update ]
    #
    # To skip this in a subclassed controller:
    #
    #   skip_before_filter :login_required
    #
    def login_required
      authorized? || access_denied
    end

    # Redirect as appropriate when an access request fails.
    #
    # The default action is to redirect to the login screen.
    #
    # Override this method in your controllers if you want to have special
    # behavior in case the sam is not authorized
    # to access the requested action.  For example, a popup window might
    # simply close itself.
    def access_denied
      respond_to do |format|
        format.html do
          store_location
          redirect_to new_session_path
        end
        # format.any doesn't work in rails version < http://dev.rubyonrails.org/changeset/8987
        # Add any other API formats here.  (Some browsers, notably IE6, send Accept: */* and trigger 
        # the 'format.any' block incorrectly. See http://bit.ly/ie6_borken or http://bit.ly/ie6_borken2
        # for a workaround.)
        format.any(:json, :xml) do
          request_http_basic_authentication 'Web Password'
        end
      end
    end

    # Store the URI of the current request in the session.
    #
    # We can return to this location by calling #redirect_back_or_default.
    def store_location
      session[:return_to] = request.request_uri
    end

    # Redirect to the URI stored by the most recent store_location call or
    # to the passed default.  Set an appropriately modified
    #   after_filter :store_location, :only => [:index, :new, :show, :edit]
    # for any controller you want to be bounce-backable.
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end

    # Inclusion hook to make #current_sam and #logged_in?
    # available as ActionView helper methods.
    def self.included(base)
      base.send :helper_method, :current_sam, :logged_in?, :authorized? if base.respond_to? :helper_method
    end

    #
    # Login
    #

    # Called from #current_sam.  First attempt to login by the sam id stored in the session.
    def login_from_session
      self.current_sam = Sam.find_by_id(session[:sam_id]) if session[:sam_id]
    end

    # Called from #current_sam.  Now, attempt to login by basic authentication information.
    def login_from_basic_auth
      authenticate_with_http_basic do |login, password|
        self.current_sam = Sam.authenticate(login, password)
      end
    end
    
    #
    # Logout
    #

    # Called from #current_sam.  Finaly, attempt to login by an expiring token in the cookie.
    # for the paranoid: we _should_ be storing sam_token = hash(cookie_token, request IP)
    def login_from_cookie
      sam = cookies[:auth_token] && Sam.find_by_remember_token(cookies[:auth_token])
      if sam && sam.remember_token?
        self.current_sam = sam
        handle_remember_cookie! false # freshen cookie token (keeping date)
        self.current_sam
      end
    end

    # This is ususally what you want; resetting the session willy-nilly wreaks
    # havoc with forgery protection, and is only strictly necessary on login.
    # However, **all session state variables should be unset here**.
    def logout_keeping_session!
      # Kill server-side auth cookie
      @current_sam.forget_me if @current_sam.is_a? Sam
      @current_sam = false     # not logged in, and don't do it for me
      kill_remember_cookie!     # Kill client-side auth cookie
      session[:sam_id] = nil   # keeps the session but kill our variable
      # explicitly kill any other session variables you set
    end

    # The session should only be reset at the tail end of a form POST --
    # otherwise the request forgery protection fails. It's only really necessary
    # when you cross quarantine (logged-out to logged-in).
    def logout_killing_session!
      logout_keeping_session!
      reset_session
    end
    
    #
    # Remember_me Tokens
    #
    # Cookies shouldn't be allowed to persist past their freshness date,
    # and they should be changed at each login

    # Cookies shouldn't be allowed to persist past their freshness date,
    # and they should be changed at each login

    def valid_remember_cookie?
      return nil unless @current_sam
      (@current_sam.remember_token?) && 
        (cookies[:auth_token] == @current_sam.remember_token)
    end
    
    # Refresh the cookie auth token if it exists, create it otherwise
    def handle_remember_cookie!(new_cookie_flag)
      return unless @current_sam
      case
      when valid_remember_cookie? then @current_sam.refresh_token # keeping same expiry date
      when new_cookie_flag        then @current_sam.remember_me 
      else                             @current_sam.forget_me
      end
      send_remember_cookie!
    end
  
    def kill_remember_cookie!
      cookies.delete :auth_token
    end
    
    def send_remember_cookie!
      cookies[:auth_token] = {
        :value   => @current_sam.remember_token,
        :expires => @current_sam.remember_token_expires_at }
    end

end
