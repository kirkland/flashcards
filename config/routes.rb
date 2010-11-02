Flashcards::Application.routes.draw do
  resources :cards

  resources :decks do
    member do
      get :game
    end
  end

  resources :quiz, :only => [:index, :new]

  root :to => 'decks#index'
end
