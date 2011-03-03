class DecksController < ApplicationController
  def index
    @decks = params[:all] ? Deck.all : Deck.where(:active => true)
  end
end
