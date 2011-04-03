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

  resources :decks, :only => [:index] do
    member do
      post :hide
    end
  end

  resources :quiz, :only => [:new, :show] do
    member do
      get :play
      get :card
      post :update_quiz_card
    end
  end

  resources :review, :only => [:show]

  root :to => 'decks#index'

  namespace :admin do
    get '/' => 'dashboard#index'
    resources :decks do
      member do
        post :activate
        post :deactivate
      end

      collection do
        match :add_one_card
      end
    end
  end
end
