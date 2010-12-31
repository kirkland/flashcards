class User < ActiveRecord::Base
  acts_as_authentic

  has_many :quizzes

  def last_five_scores(deck_id, back_to_front)
    qs = quizzes.where(:deck_id => deck_id, :back_to_front => back_to_front).order(:created_at).last(5).collect{|x| x.quiz_cards.correct.count}.join(", ")
  end

  # best score from #count last tries
  def best_score(deck_id, back_to_front)
    qs = quizzes.where(:deck_id => deck_id, :back_to_front => back_to_front).order(:created_at).last(5)
    qs.collect{|x| x.quiz_cards.correct.count}.max
  end

  def worst_score(deck_id, back_to_front)
    qs = quizzes.where(:deck_id => deck_id, :back_to_front => back_to_front).order(:created_at).last(5)
    qs.collect{|x| x.quiz_cards.correct.count}.min
  end
end
