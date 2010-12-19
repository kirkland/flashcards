class User < ActiveRecord::Base
  acts_as_authentic

  has_many :quizzes

  def deck_mastery(deck_id, back_to_front=false)
    (quizzes.where(:deck_id => deck_id, :back_to_front => back_to_front).collect{|x| x.quiz_cards.correct.count}.max.to_f / Deck.find(deck_id).cards.count * 10).floor
  end
end
