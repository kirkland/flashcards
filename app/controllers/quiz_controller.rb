class QuizController < ApplicationController
  before_filter :find_quiz, :except => [:index, :new]

  def index
    @decks = Deck.all
  end

  def new
    @deck = Deck.find(params[:deck_id])
    @quiz = Quiz.create(:deck => @deck, :user => current_user, :back_to_front => params[:show] == 'back')
    @quiz.start_quiz

    redirect_to quiz_path(@quiz)
  end

  def show
    @quiz_data = @quiz.data.to_json.html_safe
    @update_path = quiz_path(@quiz)
  end

  def update_quiz_card
    quiz_card = QuizCard.find(params[:qc_id])
    quiz_card.correct = params[:correct] == "" ? nil : params[:correct] == "true"
    quiz_card.visited = params[:visited] == "true"
    quiz_card.save

    @quiz.update_attribute(:active_card_id, params[:qc_id])

    render :text => params.inspect
  end

  private

  def find_quiz
    @quiz = Quiz.find(params[:id])
  end
end
