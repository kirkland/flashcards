Flashcards::Application.routes.draw do
  resources :users do
    member do
      get :profile
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
    resources :decks
  end
end
