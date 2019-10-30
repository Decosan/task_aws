Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  
  root to: "sessions#new"
  
  resources :users, only:[:new,:show,:create,:edit,:update] do
    member do
      get :anaylsis
    end
  end

  resources :tasks
  
  namespace :admin do
    resources :users
  end

  resources :sessions, only:[:new,:create,:destroy]

  resources :groups

  resources :user_groups, only:[:create,:destroy]

  resources :labels, only:[:new,:create,:edit,:update,:destroy]

end
