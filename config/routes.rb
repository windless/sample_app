SampleApp::Application.routes.draw do
  match '/help' => 'static_pages#help'
  match '/about' => 'static_pages#about'

  root :to => 'static_pages#home'
end
