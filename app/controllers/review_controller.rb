class ReviewController < ApplicationController
  def index
    @decks = params[:all] ? Deck.all : Deck.where(:active => true)
  end

  def show
    @deck_data = Deck.find(params[:id]).review_data.to_json
    @show = params[:show]
  end
end
