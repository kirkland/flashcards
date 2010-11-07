Flashcards::Application.routes.draw do
  resources :cards

  resources :decks

  resources :quiz, :only => [:index, :new] do
    member do
      get :play
      get :card_back
      post :next_card
    end
  end

  root :to => 'quiz#index'
end
