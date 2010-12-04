class QuizCard < ActiveRecord::Base
  belongs_to :quiz
  belongs_to :card

  scope :not_visited, :conditions => {:visited => false}
  scope :visited, :conditions => {:visited => true}
  scope :correct, :conditions => {:correct => true}
  scope :incorrect, :conditions => {:correct => false}

  def front
    card.front
  end

  def back
    card.back
  end
end
