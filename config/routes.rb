Flashcards::Application.routes.draw do
  resources :users do
    member do
      get :profile
      get :quiz_details
    end
  end

  get "login" => "user_sessions#new"
  get "logout" => "user_sessions#destroy"

  resources :user_sessions

  resources :cards

  resources :quiz, :only => [:index, :new, :show] do
    member do
      get :play
      get :card
      post :update_quiz_card
    end
  end

  root :to => 'quiz#index'

  namespace :admin do
    get '/' => 'dashboard#index'
    resources :decks do
      member do
        post :activate
        post :deactivate
      end
    end
  end
end
