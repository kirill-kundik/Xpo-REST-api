Rails.application.routes.draw do
  devise_for :users,
             defaults: { format: :json },
             class_name: 'User',
             path: '',
             path_names: {
               sign_in: 'auth/login',
               sign_out: 'auth/logout',
               registration: 'auth/signup'
             },
             controllers: {
               sessions: 'auth/sessions',
               registrations: 'auth/registrations'
             }
  resources :users, param: :id
  resources :expos, param: :id
  resources :comment, param: :id
  resources :expo_models, param: :id
  post '/visits', to: 'visits_likes#visit'
  post '/likes', to: 'visits_likes#like'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
