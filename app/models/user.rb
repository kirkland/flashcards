class User < ActiveRecord::Base
  acts_as_authentic

  has_many :quizzes

  # average percent correct, on a scale of 0-10, rounded down
  # consider only 5 most recent quizzes, and if < 5, do as if scored 0 on some
  def deck_mastery(deck_id, back_to_front)
    qs = quizzes.where(:deck_id => deck_id, :back_to_front => back_to_front).order(:created_at).last(5)
    (qs.collect{|x| x.quiz_cards.correct.count}.sum.to_f / 5 / Deck.find(deck_id).cards.count * 10).floor
  end
end
