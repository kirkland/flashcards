Flashcards::Application.routes.draw do
  resources :cards

  resources :decks do
    member do
      get :game
    end
  end

  resources :quiz, :only => [:index, :new] do
    collection do
      get :play
    end
  end

  root :to => 'quiz#index'
end
