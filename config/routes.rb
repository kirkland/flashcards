Flashcards::Application.routes.draw do
  get "users/new"

  get "users/edit"

  resources :users

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
