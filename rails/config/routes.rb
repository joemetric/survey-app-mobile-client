ActionController::Routing::Routes.draw do |map|
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.current_user '/users/current', :controller => 'users', :action=>'show_current'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.resources :users
  
  map.resource :session
  

  map.root :controller => 'surveys'

  map.resources :surveys do |survey|
    survey.resources :questions
  end

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
