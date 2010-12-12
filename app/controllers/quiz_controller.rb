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
    if params[:active_card_id].present?
      @quiz.update_attribute(:active_card_id, params[:active_card_id])
      QuizCard.find(params[:active_card_id]).update_attribute(:visited, true)
    end
    QuizCard.find(params[:correct_card]).update_attribute(:correct, true) if params[:correct_card].present?
    QuizCard.find(params[:incorrect_card]).update_attribute(:correct, false) if params[:incorrect_card].present?

    render :json => @quiz.quiz_status
  end

  private

  def find_quiz
    @quiz = Quiz.find(params[:id])
  end
end
