ActionController::Routing::Routes.draw do |map|
  map.resources :pictures
  map.resources :completions
  map.resources :answers

  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  # map.current_user '/users/current/:id', :controller => 'users', :action=>'show_current'
  map.signup '/signup', :controller => 'users', :action => 'new'
  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil
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
