Flashcards::Application.routes.draw do
  resources :cards
  resources :decks do
    member do
      get :game
    end
  end
end
