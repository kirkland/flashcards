class QuizController < ApplicationController
  def index
    @decks = Deck.all
  end

  def new
    @deck = Deck.find(params[:deck_id])
    @quiz = Quiz.create(:deck => @deck, :game_data => {:cards_remaining => @deck.cards.collect{|c| c.id.inspect}.shuffle})
    session[:quiz_id] = @quiz.id

    redirect_to :action => :play
  end

  def play
    @quiz = Quiz.find(session[:quiz_id])
    available_cards = @quiz.game_data[:cards_remaining]
    redirect_to :action => :index and return if available_cards.empty?
    @card = Card.find(available_cards.pop)
    @quiz.save

    render :text => @card.front
  end
end
