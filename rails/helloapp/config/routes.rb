Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  
  get '/hello', to: 'home#hello'

  get '/hello/:id', to: 'home#hello'

  resources :courses do
    member do
      get :do_smth_with_course
    end
    collection do
      put :do_smth_with_all_courses
      delete :destroy_all
    end
  end
end
