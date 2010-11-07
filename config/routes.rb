Flashcards::Application.routes.draw do
  resources :cards

  resources :decks

  resources :quiz, :only => [:index, :new] do
    collection do
      get :play
    end
  end

  root :to => 'quiz#index'
end
