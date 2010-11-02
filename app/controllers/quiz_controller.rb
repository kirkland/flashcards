class QuizController < ApplicationController
  def index
    @decks = Deck.all
  end

  def new
    @deck = Deck.find(params[:deck_id])
    render :text => "Start of new quiz for deck ##{@deck.id}"
  end
end
