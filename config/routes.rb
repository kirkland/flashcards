Flashcards::Application.routes.draw do
  resources :cards
  resources :decks do
    member do
      get :game
    end
  end

  root :to => 'decks#index'
end
