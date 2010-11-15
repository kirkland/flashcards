class QuizController < ApplicationController
  before_filter :find_quiz, :except => [:index, :new]

  def index
    @decks = Deck.all
  end

  def new
    @deck = Deck.find(params[:deck_id])
    @quiz = Quiz.create(:deck => @deck)
    @quiz.create_quiz_cards

    redirect_to quiz_path(@quiz)
  end

  def card_back
    render :text => Card.find(session[:card_id]).back
  end

  def next_card
    card = @quiz.next_card(params[:correct])
    if card == "no more cards"
      render :json => {:front => "no more cards", :status_string => @quiz.progress_string} and return
    else
      session[:card_id] = card.id
      render :json => {:front => card.front, :status_string => @quiz.progress_string} and return
    end
  end

  private

  def find_quiz
    @quiz = Quiz.find(params[:id])
  end
end
