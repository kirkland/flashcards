class QuizController < ApplicationController
  before_filter :find_quiz, :except => [:index, :new]

  def index
    @decks = Deck.all
  end

  def new
    @deck = Deck.find(params[:deck_id])
    @quiz = Quiz.create(:deck => @deck, :game_data => {:cards_remaining => @deck.cards.collect{|c| c.id.inspect}.shuffle})

    redirect_to quiz_path(@quiz)
  end

  def show
  end

  def card_back
    render :text => Card.find(session[:card_id]).back
  end

  def next_card
    available_cards = @quiz.game_data[:cards_remaining]
    if available_cards.empty?
      render :text => "no more cards" and return
    else
      @card = Card.find(available_cards.pop)
      session[:card_id] = @card.id
      @quiz.save
      render :text => @card.front and return
    end
  end

  private

  def find_quiz
    @quiz = Quiz.find(params[:id])
  end
end
