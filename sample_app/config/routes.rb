Rails.application.routes.draw do
  get 'users/new'

  root 'static_pages#home'
  #get 'static_pages/home' # Will be called static_pages_home_url
  get '/help',    to: 'static_pages#help' # shorter, named routes 
  get '/about',   to: 'static_pages#about' # , as: 'foo' will let you use a different name (foo_url, foo_path)
  get '/contact', to: 'static_pages#contact'
  get '/signup',  to: 'users#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
