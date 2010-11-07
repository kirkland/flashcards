class QuizController < ApplicationController
  before_filter :find_quiz, :except => [:index, :new]

  def index
    @decks = Deck.all
  end

  def new
    @deck = Deck.find(params[:deck_id])
    @quiz = Quiz.create(:deck => @deck, :game_data => {:cards_remaining => @deck.cards.collect{|c| c.id.inspect}.shuffle})
    session[:quiz_id] = @quiz.id

    redirect_to :action => :play, :id => @quiz.id
  end

  def play
    available_cards = @quiz.game_data[:cards_remaining]
    redirect_to :action => :index and return if available_cards.empty?
    @card = Card.find(available_cards.pop)
    session[:card_id] = @card.id
    @quiz.save
  end

  def card_back
    render :text => Card.find(session[:card_id]).back
  end

  def next_card
    available_cards = @quiz.game_data[:cards_remaining]
    @card = Card.find(available_cards.pop)
    session[:card_id] = @card.id
    @quiz.save
    render :text => available_cards.empty? ? "no more cards" : @card.front
  end

  private

  def find_quiz
    @quiz = Quiz.find(session[:quiz_id])
  end
end
