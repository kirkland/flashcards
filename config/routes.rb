Flashcards::Application.routes.draw do
  resources :users
  get "login" => "user_sessions#new"
  get "logout" => "user_sessions#destroy"
  resources :user_sessions

  resources :cards

  resources :decks

  resources :quiz, :only => [:index, :new, :show] do
    member do
      get :play
      get :card_back
      post :next_card
    end
  end

  root :to => 'quiz#index'
end
