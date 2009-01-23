module AuthenticatedTestHelper
  # Sets the current sam in the session from the sam fixtures.
  def login_as(sam)
    @request.session[:sam_id] = sam ? sams(sam).id : nil
  end

  def authorize_as(sam)
    @request.env["HTTP_AUTHORIZATION"] = sam ? ActionController::HttpAuthentication::Basic.encode_credentials(sams(sam).login, 'monkey') : nil
  end
  
end
