ActionController::Routing::Routes.draw do |map|
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'sams', :action => 'create'
  map.signup '/signup', :controller => 'sams', :action => 'new'
  map.resources :sams

  map.resource :session

  map.root :controller => 'campaigns'

  map.resources :campaigns do |campaign|
    campaign.resources :questions
  end

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
